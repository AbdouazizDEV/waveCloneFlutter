// lib/views/pages/account/account_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import './widgets/profile_header.dart';
import './widgets/settings_section.dart';
import './widgets/settings_tile.dart';
import '../../../providers/auth_notifier.dart';
import '../../../models/user.dart';
import './widgets/qr_code_dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isDarkMode = false;

  void _handleSignOut(BuildContext context) async {
    final authNotifier = context.read<AuthNotifier>();
    
    // Afficher un dialog de confirmation
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Déconnexion',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      try {
        await authNotifier.logout();
        if (mounted) {
          context.go('/login');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur lors de la déconnexion: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authNotifier, _) {
        final User? user = authNotifier.user;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Mon Compte',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ProfileHeader(
                  name: user.fullName,
                  email: user.email,
                  phoneNumber: user.telephone,
                  qrCodeUrl: user.carte,  // URL du QR code
                ),
                const SizedBox(height: 20),
                SettingsSection(
                  title: 'Général',
                  children: [
                    SettingsTile(
                      icon: Icons.qr_code,
                      title: 'Ma Carte QR',
                      onTap: () {
                        // TODO: Afficher le QR code en grand
                        Navigator.pushNamed(context, '/qr');
                      },
                    ),
                    SettingsTile(
                      icon: Icons.credit_card,
                      title: 'État de la Carte',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => QRCodeDialog(
                            qrCodeUrl: user.carte,
                            userName: user.fullName,
                          ),
                        );
                      },
                    ),
                    SettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Changer le code',
                      onTap: () {
                        // TODO: Navigation vers changement de code
                      },
                    ),
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {
                        // TODO: Navigation vers les notifications
                      },
                    ),
                    SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Mode Sombre',
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() => _isDarkMode = value);
                          // TODO: Implémenter le changement de thème
                        },
                        activeColor: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Support',
                  children: [
                    SettingsTile(
                      icon: Icons.help_outline,
                      title: 'Centre d\'aide',
                      onTap: () {
                        // TODO: Navigation vers le centre d'aide
                      },
                    ),
                    SettingsTile(
                      icon: Icons.policy_outlined,
                      title: 'Conditions d\'utilisation',
                      onTap: () {
                        // TODO: Navigation vers les conditions
                      },
                    ),
                    SettingsTile(
                      icon: Icons.info_outline,
                      title: 'À propos de Wave',
                      onTap: () {
                        // TODO: Navigation vers à propos
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _handleSignOut(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Déconnexion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}