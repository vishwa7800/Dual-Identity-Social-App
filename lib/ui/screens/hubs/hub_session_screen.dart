import 'package:flutter/material.dart';
import '../../widgets/shrowd_layout.dart';

class HubSessionScreen extends StatelessWidget {
  final bool isPublic;

  const HubSessionScreen({super.key, required this.isPublic});

  @override
  Widget build(BuildContext context) {
    return ShrowdLayout(
      showTopToggle: false,
      showBottomNav: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D12),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Stack(
                  children: [
                    _buildParticipantGrid(),
                    _buildOverlayControls(),
                  ],
                ),
              ),
              _buildControlBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPublic ? 'PUBLIC HUB' : 'PRIVATE HUB',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 12),
              ),
              const Text('Late Night Vibes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('LIVE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantGrid() {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        _buildParticipantCard('You', 'https://i.pravatar.cc/150?u=me', isTalking: true),
        _buildParticipantCard('Sarah', 'https://i.pravatar.cc/150?u=1'),
        _buildParticipantCard('John', 'https://i.pravatar.cc/150?u=2'),
        if (!isPublic) _buildParticipantCard('Elena', 'https://i.pravatar.cc/150?u=3'),
      ],
    );
  }

  Widget _buildParticipantCard(String name, String avatar, {bool isTalking = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: BorderRadius.circular(24),
        border: isTalking ? Border.all(color: const Color(0xFF00E5FF), width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(radius: 35, backgroundImage: NetworkImage(avatar)),
              if (isTalking)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                  child: const Icon(Icons.mic, size: 12, color: Colors.black),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOverlayControls() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        children: [
          _buildCircleAction(Icons.screen_share_outlined),
          const SizedBox(height: 15),
          _buildCircleAction(Icons.videocam_outlined),
          const SizedBox(height: 15),
          _buildCircleAction(Icons.chat_bubble_outline),
        ],
      ),
    );
  }

  Widget _buildCircleAction(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _buildControlBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.volume_up_rounded, color: Colors.white70),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.1),
              border: Border.all(color: Colors.red.withOpacity(0.5), width: 2),
            ),
            child: const Icon(Icons.mic_off_rounded, color: Colors.red, size: 30),
          ),
          const Icon(Icons.back_hand_outlined, color: Colors.white70),
        ],
      ),
    );
  }
}
