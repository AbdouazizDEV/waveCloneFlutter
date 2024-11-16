// lib/utils/constants/api_urls.dart

class ApiUrls {
  // Assurez-vous que c'est l'adresse IP de votre machine
 static const String baseUrl = 'http://192.168.148.58:8000/api';
  
  // Auth endpoints
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String register = '$baseUrl/register';
  
  // Transaction endpoints
  static const String transfer = '$baseUrl/transfer';
  static const String transactions = '$baseUrl/transactions';
  
  // User endpoints
  static const String userProfile = '$baseUrl/me';
  
  // Contact endpoints
  static const String contacts = '$baseUrl/contacts';
}