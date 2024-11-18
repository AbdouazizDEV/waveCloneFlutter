// lib/services/http/api_endpoints.dart
class ApiEndpoints {
  //static const String baseUrl = 'YOUR_BASE_URL';
  
  // Auth endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String me = '/me';
    static const String testConnection = '/test-connection';
  // User endpoints
  static const String userProfile = '/user';
  static const String updateProfile = '/users/update-profile';
  static const String userTransactions = '/user/transactions';
  static const String userBalance = '/user/balance';
  static const String userFavorites = '/user/favoris';
  static const String userStats = '/user/stats';
  static const String userQr = '/user/qr';
  
  // Transaction endpoints
  static const String transfer = '/transfer';
  static const String scheduleTransfer = '/transfer/schedule';
  static const String multipleTransfer = '/transfer/multiple';
  static const String cancelTransfer = '/transfer/cancel';
  static const String transactionHistory = '/transactions/history';
  static const String verifyQrCode = '/transactions/verify-qr';
  
  // Merchant endpoints
  static const String merchantPay = '/merchant/pay';
  static const String merchantStats = '/merchant/stats';
}
