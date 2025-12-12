// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Connexion
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } catch (e) {
      return null;
    }
  }

  // Inscription (nouveau !)
  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // On crée automatiquement le profil utilisateur avec rôle "client"
      await _db.collection('users').doc(result.user!.uid).set({
        'email': email,
        'role': 'client',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return result.user;
    } catch (e) {
      return null;
    }
  }

  // Vérifie si admin
  Future<bool> isAdmin(User user) async {
    final doc = await _db.collection('users').doc(user.uid).get();
    return doc.exists && doc.data()?['role'] == 'admin';
  }

  // Déconnexion
  Future<void> signOut() => _auth.signOut();
}
