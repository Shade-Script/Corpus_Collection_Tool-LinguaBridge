import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linguabridge/src/features/auth/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository(this._firebaseAuth, this._firestore);

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<AppUser?> watchAppUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return const AppUser(uid: '', email: '', totalPoints: 0);
      return AppUser.fromJson(doc.data()!);
    });
  }

  Stream<List<AppUser>> watchLeaderboard() {
    return _firestore
        .collection('users')
        .orderBy('totalPoints', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppUser.fromJson(doc.data()))
            .toList());
  }

  Future<void> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // Ensure user doc exists (handles cases where user data was wiped)
    if (userCredential.user != null) {
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
    }
  }

  Future<void> signUpWithEmail(String email, String password, String displayName) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    
    if (userCredential.user != null) {
      final newUser = AppUser(
        uid: userCredential.user!.uid, 
        email: email,
        displayName: displayName,
      );
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toJson());
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return; // The user canceled the sign-in

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    // Always upsert user doc — handles re-login after account data was cleared
    if (userCredential.user != null) {
      final userDoc = _firestore.collection('users').doc(userCredential.user!.uid);
      await userDoc.set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email ?? googleUser.email,
        'displayName': userCredential.user!.displayName ?? googleUser.displayName ?? 'Google User',
      }, SetOptions(merge: true)); // merge: true preserves existing totalPoints
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      // Step 1: Destroy the app's User document payload first (points, email cache)
      await _firestore.collection('users').doc(user.uid).delete();
      
      // Step 2: Delete their Firebase Identity (This handles the requires-recent-login trap internally if it faults)
      await user.delete();
      
      // Step 3: Purge any cached Google OAuth sessions so they can't maliciously relog instantly
      await _googleSignIn.signOut();
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
}

@Riverpod(keepAlive: true)
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@riverpod
Stream<AppUser?> watchAppUser(WatchAppUserRef ref, String uid) {
  if (uid.isEmpty) return const Stream.empty();
  return ref.watch(authRepositoryProvider).watchAppUser(uid);
}

@riverpod
Stream<List<AppUser>> watchLeaderboard(WatchLeaderboardRef ref) {
  return ref.watch(authRepositoryProvider).watchLeaderboard();
}
