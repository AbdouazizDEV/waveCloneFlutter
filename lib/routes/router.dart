// lib/routes/router.dart
import 'package:go_router/go_router.dart';
import '../views/pages/layouts/main_layout.dart';
import '../views/pages/home/home_page.dart';
 import '../views/pages/contacts/contacts_page.dart';
 import '../views/pages/insights/insights_page.dart';
import '../views/pages/account/account_page.dart';
import '../views/pages/auth/login_page.dart';
import '../views/pages/auth/register_page.dart';
 import '../views/pages/transfer/transfer_page.dart';

final router = GoRouter(
  initialLocation: '/login',
   routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => MainLayout(
        currentIndex: 0,
        child: HomePage(),
      ),
    ),
     GoRoute(
      path: '/contacts',
      builder: (context, state) => const MainLayout(
        currentIndex: 1,
        child: ContactsPage(),
      ),
    ),
     GoRoute(
      path: '/transfer',
      builder: (context, state) => const MainLayout(
        currentIndex: 2,
        child: TransferPage(),
      ),
    ),
    GoRoute(
      path: '/insights',
      builder: (context, state) => const MainLayout(
        currentIndex: 3,
        child: InsightsPage(),
      ),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const MainLayout(
        currentIndex: 4,
        child: AccountPage(),
      ),
    ),
  ],
);