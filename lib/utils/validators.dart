// lib/utils/validators.dart
class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis';
    }
    if (value.length != 9) {
      return 'Le numéro doit contenir 9 chiffres';
    }
    final validPrefixes = ['77', '78', '76', '70', '75'];
    final prefix = value.substring(0, 2);
    if (!validPrefixes.contains(prefix)) {
      return 'Le numéro doit commencer par 77, 78, 76, 70 ou 75';
    }
    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le code est requis';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le code doit contenir au moins une lettre majuscule';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  static String? validateRequired(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field est requis';
    }
    return null;
  }
}
