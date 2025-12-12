// lib/views/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SUP4 E-Commerce",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: "Email")),
              TextField(
                  controller: _passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mot de passe")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool success =
                      await auth.login(_emailCtrl.text, _passCtrl.text);
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Erreur de connexion")));
                  }
                },
                child: const Text("Se connecter"),
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: const Text("Créer un compte"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
