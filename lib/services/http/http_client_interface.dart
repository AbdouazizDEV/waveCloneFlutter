// lib/services/http/http_client_interface.dart
abstract class HttpClientInterface {
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> post(String url, {dynamic data});
  Future<Map<String, dynamic>> put(String url, {dynamic data});
  Future<Map<String, dynamic>> delete(String url);
  
  void setAuthToken(String token);
  void removeAuthToken();
}
