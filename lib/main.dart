import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linguabridge/firebase_options.dart';
import 'package:linguabridge/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase (commented out until options file is generated or for mock mode)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // For now, run app with just ProviderScope
  runApp(const ProviderScope(child: LinguaBridgeApp()));
}
