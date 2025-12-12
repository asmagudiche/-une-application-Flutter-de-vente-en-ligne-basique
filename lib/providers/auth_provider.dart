// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  // États actuels
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _isAdmin = false;
  User? _currentUser;

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _isAdmin;
  User? get currentUser => _currentUser;

  // Instances Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider() {
    // Écoute les changements d'état d'authentification en temps réel
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  /// Appelé automatiquement à chaque connexion/déconnexion
  Future<void> _onAuthStateChanged(User? user) async {
    _isLoading = true;
    notifyListeners();

    if (user == null) {
      _isLoggedIn = false;
      _isAdmin = false;
      _currentUser = null;
    } else {
      _currentUser = user;
      _isLoggedIn = true;

      // On récupère le rôle depuis Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data()?['role'] == 'admin') {
        _isAdmin = true;
      } else {
        _isAdmin = false;
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Connexion classique
  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Le listener _onAuthStateChanged fera le reste
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Inscription avec choix du rôle (admin ou client)
  /// Utilisé dans register_screen.dart
  Future<bool> registerWithRole({
    required String email,
    required String password,
    required String role, // "client" ou "admin"
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Création de l'utilisateur Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Création du document utilisateur dans Firestore avec le rôle choisi
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email.trim(),
        'role': role, // "admin" ou "client"
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Le listener mettra à jour isAdmin automatiquement
      return true;
    } catch (e) {
      if (kDebugMode) print("Erreur inscription : $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
    // Le listener _onAuthStateChanged gérera la mise à jour
  }
}
