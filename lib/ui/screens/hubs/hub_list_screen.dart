import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/economy_service.dart';
import '../../widgets/shrowd_layout.dart';
import 'hub_session_screen.dart';

class HubListScreen extends StatelessWidget {
  const HubListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShrowdLayout(
      showTopToggle: true,
      selectedNavIndex: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('GALAXY HUBS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildCreateHubSection(context),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('LIVE HUBS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildHubCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateHubSection(BuildContext context) {
    final economy = Provider.of<EconomyService>(context);
    
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF9D00FF).withOpacity(0.2), const Color(0xFF00E5FF).withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          const Text(
            'START A NEW SESSION',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
          const SizedBox(height: 10),
          const Text(
            'Connect with your galaxy in real-time.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildCreateButton(
                  context,
                  'PUBLIC HUB',
                  'Max 5 people • 2h',
                  Icons.public,
                  () => _createHub(context, economy, true),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildCreateButton(
                  context,
                  'PRIVATE HUB',
                  'Unlimited • Invite Only',
                  Icons.lock_outline,
                  () => _createHub(context, economy, false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF00E5FF), size: 24),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 9)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bolt_rounded, color: Colors.amber, size: 12),
                const SizedBox(width: 4),
                const Text('0.5', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createHub(BuildContext context, EconomyService economy, bool isPublic) {
    if (economy.spendEssence('Open ${isPublic ? 'Public' : 'Private'} Hub', 0.5)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HubSessionScreen(isPublic: isPublic)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough Essence!')),
      );
    }
  }

  Widget _buildHubCard(BuildContext context, int index) {
    final titles = ['Late Night Vibes', 'Tech Talk', 'Gaming Lounge'];
    final members = ['3/5', '2/5', '4/5'];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0xFFFF00D6), Color(0xFF9D00FF)]),
            ),
            child: const Icon(Icons.hub_outlined, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titles[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('Hosted by Alexander Marcus', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              Text(members[index], style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HubSessionScreen(isPublic: true))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  minimumSize: const Size(60, 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('JOIN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
