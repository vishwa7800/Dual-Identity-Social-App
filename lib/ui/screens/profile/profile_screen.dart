import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/identity_service.dart';
import '../../widgets/shrowd_layout.dart';
import '../settings/settings_screen.dart';
import '../economy/wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _bio = "Architect of shadows. Exploring the digital veil.";
  String _username = "Alexander Marcus";

  @override
  Widget build(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);
    final bool isWanderer = identity.isWanderer;

    return ShrowdLayout(
      selectedNavIndex: 4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(identity),
            const SizedBox(height: 60),
            _buildStats(),
            const SizedBox(height: 24),
            _buildBio(isWanderer),
            const SizedBox(height: 32),
            _buildTabs(),
            _buildPostsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(IdentityService identity) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Banner
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(identity.isWanderer 
                ? 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1000'
                : 'https://images.unsplash.com/photo-1614850523296-e8c041de4032?q=80&w=1000'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Colors.white),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Avatar
        Positioned(
          bottom: -50,
          left: 20,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D0D12),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(identity.activeAvatar),
                ),
              ),
              if (!identity.isWanderer)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
            ],
          ),
        ),
        // Action Buttons
        Positioned(
          bottom: -45,
          right: 20,
          child: Row(
            children: [
              _buildActionButton('Edit Profile', () {}),
              const SizedBox(width: 10),
              _buildActionButton('Share', () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Provider.of<IdentityService>(context).activeUsername,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                '@alex_marcus',
                style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          _buildStatItem('1.2k', 'Followers'),
          const SizedBox(width: 20),
          _buildStatItem('842', 'Following'),
          const SizedBox(width: 20),
          _buildStatItem('4.5k', 'Likes'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 11)),
      ],
    );
  }

  Widget _buildBio(bool isWanderer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('BIO', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit, size: 16, color: Color(0xFF8E8E93))),
            ],
          ),
          Text(
            _bio,
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab('Posts', true),
          _buildTab('Wires', false),
          _buildTab('Media', false),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: active ? const Border(bottom: BorderSide(color: Color(0xFF6366F1), width: 2)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : const Color(0xFF8E8E93),
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white.withOpacity(0.05),
          child: Image.network(
            'https://picsum.photos/seed/${index + 50}/200',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
