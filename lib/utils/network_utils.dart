// lib/utils/network_utils.dart

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static const String serverIp = '192.168.224.58';
  static const int serverPort = 8000;

  static Future<String> checkConnectivity() async {
    try {
      // Vérifier la connexion Internet
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return 'Pas de connexion Internet';
      }

      // Tester la connexion au serveur
      try {
        final socket = await Socket.connect(
          serverIp,
          serverPort,
          timeout: const Duration(seconds: 5),
        );
        socket.destroy();
        return 'OK';
      } catch (e) {
        return 'Serveur inaccessible\n'
            'Vérifiez que:\n'
            '1. L\'adresse IP $serverIp est correcte\n'
            '2. Le serveur Laravel est démarré avec --host=0.0.0.0\n'
            '3. Le téléphone est sur le même réseau WiFi';
      }
    } catch (e) {
      return 'Erreur de connexion: $e';
    }
  }
}