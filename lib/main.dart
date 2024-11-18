// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/router.dart';
import 'services/http/dio_client.dart';
import 'services/auth_service.dart';
import 'providers/auth_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide DioClient
        Provider<DioClient>(
          create: (_) => DioClient(),
        ),
        // Provide AuthService
        ProxyProvider<DioClient, AuthService>(
          create: (context) => AuthService(context.read<DioClient>()),
          update: (context, dioClient, previous) => 
            previous ?? AuthService(dioClient),
        ),
        // Provide AuthNotifier
        ChangeNotifierProxyProvider<AuthService, AuthNotifier>(
          create: (context) => AuthNotifier(context.read<AuthService>()),
          update: (context, authService, previous) => 
            previous ?? AuthNotifier(authService),
        ),
      ],
      child: MaterialApp.router(
        title: 'Wave Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
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
        routerConfig: router,
      ),
    );
  }
}