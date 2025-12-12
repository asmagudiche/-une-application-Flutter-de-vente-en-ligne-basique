// lib/views/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String _selectedRole = 'client'; // client par défaut
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          elevation: 12,
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo / Icône
                    const Icon(Icons.person_add_alt_1,
                        size: 80, color: Colors.indigo),
                    const SizedBox(height: 20),
                    const Text(
                      'Créer un compte',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    const SizedBox(height: 30),

                    // Email
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Email requis';
                        if (!value.contains('@')) return 'Email invalide';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Mot de passe
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Mot de passe requis';
                        if (value.length < 6) return 'Minimum 6 caractères';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirmer mot de passe
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value != _passwordCtrl.text)
                          return 'Les mots de passe ne correspondent pas';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Choix du rôle : Admin ou Client
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        labelText: 'Type de compte',
                        prefixIcon: const Icon(Icons.supervised_user_circle),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'client', child: Text('Client (Acheteur)')),
                        DropdownMenuItem(
                            value: 'admin', child: Text('Administrateur')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // Bouton Inscription
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 6,
                        ),
                        onPressed: _isLoading ? null : _handleRegister,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('S\'inscrire',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Déjà un compte ? Se connecter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await context.read<AuthProvider>().registerWithRole(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
          role: _selectedRole, // "client" ou "admin"
        );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_selectedRole == 'admin'
              ? 'Administrateur créé avec succès !'
              : 'Compte client créé avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Retour automatique à la page de connexion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de l\'inscription'),
            backgroundColor: Colors.red),
      );
    }
  }
}
