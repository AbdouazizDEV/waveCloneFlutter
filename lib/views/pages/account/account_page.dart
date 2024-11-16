// lib/views/pages/account/account_page.dart
import 'package:flutter/material.dart';
import './widgets/profile_header.dart';
import './widgets/settings_section.dart';
import './widgets/settings_tile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ProfileHeader(
              name: 'Williams Green',
              email: 'WilliamsGreen@gmail.com',
              imageUrl: 'assets/images/WhatsApp Image 2024-04-29 at 17.09.21 (1).jpeg',
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'General',
              children: [
                SettingsTile(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  onTap: () {
                    // TODO: Navigation vers les méthodes de paiement
                  },
                ),
                SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Personal Info',
                  onTap: () {
                    // TODO: Navigation vers les infos personnelles
                  },
                ),
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notification',
                  onTap: () {
                    // TODO: Navigation vers les notifications
                  },
                ),
                SettingsTile(
                  icon: Icons.security,
                  title: 'Security',
                  onTap: () {
                    // TODO: Navigation vers la sécurité
                  },
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  trailing: const Text(
                    'English (US)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    // TODO: Navigation vers les langues
                  },
                ),
                SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
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
              title: 'About',
              children: [
                SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    // TODO: Navigation vers le centre d'aide
                  },
                ),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO: Navigation vers la politique de confidentialité
                  },
                ),
                SettingsTile(
                  icon: Icons.info_outline,
                  title: 'About PayWise',
                  onTap: () {
                    // TODO: Navigation vers à propos
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  // TODO: Implémenter la déconnexion
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
