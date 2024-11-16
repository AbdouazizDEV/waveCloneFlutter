// lib/views/pages/auth/register_page.dart

import 'package:flutter/material.dart';
import './widgets/custom_text_field.dart';
import '../../../utils/validators.dart';
import '../../../models/auth/register_model.dart';
import 'package:go_router/go_router.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  String _selectedRole = 'client';

  Map<String, int> roleIds = {
    'client': 1,
    'marchand': 2,
    'agent': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hello there, Sign Up to continue!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hint: 'Nom',
                  prefixIcon: Icons.person,
                  controller: _nomController,
                  validator: (value) => Validators.validateRequired(value, 'Nom'),
                ),
                CustomTextField(
                  hint: 'Prénom',
                  prefixIcon: Icons.person,
                  controller: _prenomController,
                  validator: (value) => Validators.validateRequired(value, 'Prénom'),
                ),
                CustomTextField(
                  hint: 'Numéro de téléphone',
                  prefixIcon: Icons.phone,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                CustomTextField(
                  hint: 'Email',
                  prefixIcon: Icons.email,
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
                    items: ['client', 'marchand', 'agent']
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role.capitalize()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedRole = value!);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                CustomTextField(
                  hint: 'Code',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  controller: _codeController,
                  validator: Validators.validateCode,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      final register = RegisterModel(
        nom: _nomController.text,
        prenom: _prenomController.text,
        telephone: _phoneController.text,
        email: _emailController.text,
        roleId: roleIds[_selectedRole]!,
        code: _codeController.text,
      );
      
      // TODO: Implement register logic in AuthProvider
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}

// extensions.dart
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
