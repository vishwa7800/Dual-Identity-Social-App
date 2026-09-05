import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/identity_service.dart';
import '../../widgets/shrowd_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShrowdLayout(
      showTopToggle: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'SETTINGS',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSectionHeader('SAFETY & PRIVACY'),
                _buildSettingTile(Icons.block_flipped, 'Blocked Users', 'Manage your block list'),
                _buildSettingTile(Icons.report_problem_outlined, 'Report Content', 'Flag inappropriate behavior'),
                _buildSettingTile(Icons.lock_outline, 'Privacy Settings', 'Control who sees your activity'),
                
                const SizedBox(height: 32),
                _buildSectionHeader('SUPPORT'),
                _buildSettingTile(Icons.confirmation_number_outlined, 'Support Tickets', 'View and create support requests'),
                _buildSettingTile(Icons.description_outlined, 'Privacy Policy', 'How we handle your data'),
                _buildSettingTile(Icons.gavel_outlined, 'Terms of Service', 'Our community guidelines'),
                
                const SizedBox(height: 32),
                _buildSectionHeader('ACCOUNT'),
                _buildSettingTile(
                  Icons.logout, 
                  'Logout', 
                  'Sign out of Shrowd', 
                  color: Colors.redAccent,
                  onTap: () {
                    // Navigate back to login/signup in a real app
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle, {Color? color, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap ?? () {},
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (color ?? Colors.white).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color ?? Colors.white, size: 20),
        ),
        title: Text(title, style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(color: (color ?? Colors.white).withOpacity(0.5), fontSize: 12)),
        trailing: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2)),
      ),
    );
  }
}
