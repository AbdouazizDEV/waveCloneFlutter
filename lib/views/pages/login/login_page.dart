// lib/views/pages/login/login_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wave_mobile/providers/auth_provider.dart';
import 'package:wave_mobile/views/pages/login/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _telephoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginForm(
                telephoneController: _telephoneController,
                codeController: _codeController,
                formKey: _formKey,
                onSubmit: () => _handleLogin(context),
              ),
              SizedBox(height: 24),
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  return ElevatedButton(
                    onPressed: auth.isLoading ? null : () => _handleLogin(context),
                    child: auth.isLoading
                        ? CircularProgressIndicator()
                        : Text('Se connecter'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final success = await context.read<AuthProvider>().login(
          _telephoneController.text,
          _codeController.text,
        );
        if (success) {
          context.go('/home');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  void dispose() {
    _telephoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}
