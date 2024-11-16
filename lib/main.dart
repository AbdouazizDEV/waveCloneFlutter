// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'routes/router.dart';
import 'services/http/dio_client.dart';
import 'services/auth_service.dart';
import 'providers/auth_provider.dart';

void main() async {
  // Assurez-vous que les liaisons Flutter sont initialisées
  WidgetsFlutterBinding.ensureInitialized();

  // Exécutez l'application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Fournir le service d'authentification
        Provider<AuthService>(
          create: (_) => AuthService(DioClient()),
        ),
        // Fournir le provider d'authentification
        ChangeNotifierProxyProvider<AuthService, AuthProvider>(
          create: (context) => AuthProvider(context.read<AuthService>()),
          update: (context, authService, previous) => 
            previous ?? AuthProvider(authService),
        ),
      ],
      child: MaterialApp.router(
        title: 'Wave Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Configuration du thème
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Personnalisation des boutons
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          // Personnalisation des champs de texte
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
        // Configuration du routeur
        routerConfig: router,
      ),
    );
  }
}