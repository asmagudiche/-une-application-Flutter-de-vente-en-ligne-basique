// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  // État actuel
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _isAdmin = false;
  User? _currentUser;

  // Getters (CEUX QUE TU UTILISÉS DANS main.dart)
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _isAdmin;
  User? get currentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider() {
    // Écoute les changements d'authentification en temps réel
    _auth.authStateChanges().listen(_handleAuthChange);
  }

  Future<void> _handleAuthChange(User? user) async {
    _isLoading = true;
    notifyListeners();

    if (user == null) {
      _isLoggedIn = false;
      _isAdmin = false;
      _currentUser = null;
    } else {
      _currentUser = user;
      _isLoggedIn = true;

      // Vérifie le rôle dans Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();
      _isAdmin = doc.exists && (doc.data()?['role'] == 'admin');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Connexion
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Inscription (si tu veux permettre aux clients de s'inscrire)
  Future<bool> register(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Par défaut, tout nouveau compte est client
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email.trim(),
        'role': 'client',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
  }
}
