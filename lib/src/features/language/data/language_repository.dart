import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linguabridge/src/features/language/domain/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_repository.g.dart';

class LanguageRepository {
  final FirebaseFirestore _firestore;

  LanguageRepository(this._firestore);

  Stream<List<Language>> watchLanguages() {
    return _firestore.collection('languages')
        .orderBy('name', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Language.fromJson(doc.data()))
            .toList());
  }

  Future<void> addLanguage(Language language) async {
    await _firestore.collection('languages').doc(language.id).set(language.toJson());
  }
}

@Riverpod(keepAlive: true)
LanguageRepository languageRepository(LanguageRepositoryRef ref) {
  return LanguageRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Language>> watchLanguages(WatchLanguagesRef ref) {
  return ref.watch(languageRepositoryProvider).watchLanguages();
}
