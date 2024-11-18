// lib/views/pages/auth/widgets/register_form.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_notifier.dart';
import '../../../../models/auth/register_model.dart';
import '../../../../utils/validators.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;

  const RegisterForm({Key? key, this.onRegisterSuccess}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedRole = 'client';
  bool _isLoading = false;

  final Map<String, int> roleIds = {
    'client': 1,
    'marchand': 2,
    'agent': 3,
  };

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final registerData = RegisterModel(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        telephone: _phoneController.text.replaceAll(RegExp(r'[^\d]'), ''),
        email: _emailController.text.trim(),
        roleId: roleIds[_selectedRole]!,
      );
      //redirection vers la page login
      final success = await context.read<AuthNotifier>().register(registerData);
      if (!mounted) return;
      context.go('/login');

      if (success) {
        _showSuccessSnackBar('Compte créé avec succès');
        widget.onRegisterSuccess?.call();
        context.go('/home');
      } else {
        final error = context.read<AuthNotifier>().error;
        _showErrorSnackBar(error ?? 'Erreur lors de l\'inscription');
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hint: 'Nom',
            prefixIcon: Icons.person_outline,
            controller: _nomController,
            validator: (value) => Validators.validateRequired(value, 'Nom'),
          ),
          CustomTextField(
            hint: 'Prénom',
            prefixIcon: Icons.person_outline,
            controller: _prenomController,
            validator: (value) => Validators.validateRequired(value, 'Prénom'),
          ),
          CustomTextField(
            hint: 'Numéro de téléphone',
            prefixIcon: Icons.phone_outlined,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          CustomTextField(
            hint: 'Email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              items: roleIds.keys.map((role) => DropdownMenuItem(
                value: role,
                child: Text(
                  role[0].toUpperCase() + role.substring(1),
                  style: const TextStyle(fontSize: 16),
                ),
              )).toList(),
              onChanged: (value) {
                setState(() => _selectedRole = value!);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Type de compte',
                prefixIcon: Icon(Icons.person_pin_outlined),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Créer un compte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Déjà un compte ?'),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Connexion'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}