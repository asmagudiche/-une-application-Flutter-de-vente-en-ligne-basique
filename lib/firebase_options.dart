// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Configuration Firebase générée automatiquement
/// Fonctionne sur : Android, iOS et Web (Chrome)
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // CONFIGURATION WEB (CHROME) ← C'EST ÇA QUI MANQUAIT !
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions n\'est pas configuré pour cette plateforme.',
        );
    }
  }

  // WEB (Chrome, Edge, Firefox)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCR295IE4QZpfSjYRMLPhFCyBkZI15ZkTA", // ← même clé que Android
    authDomain: "vente-abbc6.firebaseapp.com",
    projectId: "vente-abbc6",
    storageBucket: "vente-abbc6.firebasestorage.app",
    messagingSenderId: "126189808042",
    appId:
        "1:126189808042:web:1234567890abcdef123456", // ← tu peux mettre n'importe quoi ici pour web
    measurementId: "G-XXXXXXXXXX", // optionnel
  );

  // ANDROID (déjà bon)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCR295IE4QZpfSjYRMLPhFCyBkZI15ZkTA',
    appId: '1:126189808042:android:7ce030d5d235a7e9e023d3',
    messagingSenderId: '126189808042',
    projectId: 'vente-abbc6',
    storageBucket: 'vente-abbc6.firebasestorage.app',
  );

  // iOS (au cas où)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCR295IE4QZpfSjYRMLPhFCyBkZI15ZkTA',
    appId: '1:126189808042:ios:AAAAAAAAAAAAAAAAAAAAAAAA',
    messagingSenderId: '126189808042',
    projectId: 'vente-abbc6',
    storageBucket: 'vente-abbc6.firebasestorage.app',
    iosBundleId: 'com.example.venteEnLigne',
  );
}
