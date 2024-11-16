// lib/views/pages/login/widgets/login_form.dart
import 'package:flutter/material.dart';
class LoginForm extends StatelessWidget {
  final TextEditingController telephoneController;
  final TextEditingController codeController;
  final GlobalKey<FormState> formKey;
  final Function() onSubmit;

  const LoginForm({
    Key? key,
    required this.telephoneController,
    required this.codeController,
    required this.formKey,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: telephoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Numéro de téléphone',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Veuillez entrer votre numéro';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: codeController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: 'Code',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value?.length != 6) {
                return 'Le code doit contenir 6 caractères';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
