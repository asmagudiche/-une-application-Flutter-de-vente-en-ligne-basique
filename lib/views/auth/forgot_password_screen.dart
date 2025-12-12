// lib/views/auth/forgot_password_screen.dart
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulation d'envoi d'email (3 secondes)
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mot de passe oublié'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: _emailSent ? _buildSuccessView() : _buildFormView(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.lock_reset,
            size: 90,
            color: Colors.indigo,
          ),
          const SizedBox(height: 24),
          const Text(
            'Récupérer mon mot de passe',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Entrez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Adresse email',
              prefixIcon: const Icon(Icons.email_outlined),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.indigo, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!value.contains('@')) {
                return 'Email invalide';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _sendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3),
                        ),
                        SizedBox(width: 16),
                        Text('Envoi en cours...',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ],
                    )
                  : const Text('Envoyer le lien de réinitialisation',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check_circle,
          size: 100,
          color: Colors.green,
        ),
        const SizedBox(height: 24),
        const Text(
          'Email envoyé !',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Text(
          'Un lien de réinitialisation a été envoyé à\n${_emailController.text}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Retour à la connexion',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
