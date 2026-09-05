import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/identity_service.dart';
import '../../widgets/shrowd_layout.dart';
import '../reels/reels_screen.dart';
import 'comment_sheet.dart';
import 'post_composer.dart';

class WireFeedScreen extends StatefulWidget {
  const WireFeedScreen({super.key});

  @override
  State<WireFeedScreen> createState() => _WireFeedScreenState();
}

class _WireFeedScreenState extends State<WireFeedScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        const WireFeedContent(),
        const ReelsScreen(),
      ],
    );
  }
}

class WireFeedContent extends StatelessWidget {
  const WireFeedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);
    final Color accentColor = const Color(0xFF6366F1);
    final Color secondaryTextColor = const Color(0xFF8E8E93);

    return ShrowdLayout(
      selectedNavIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(secondaryTextColor),
              _buildStories(secondaryTextColor),
              _buildRecentlyPostHeader(secondaryTextColor),
              _buildPostCard(
                context,
                userName: 'Nilesh',
                time: '1h ago',
                location: 'u8s',
                content: 'Discover adventure in Patagonia\'s peaks or serenity provence\'s @hamlets - arrival',
                imageCount: 3,
                ghostLikes: 124,
              ),
              _buildPostCard(
                context,
                userName: identity.isWanderer ? 'Wanderer#102' : 'Darlene',
                time: '45m ago',
                location: 'Nature',
                content: 'Exploring the new collection of winter wear. #fashion #style',
                imageCount: 1,
                isWanderer: identity.isWanderer,
                ghostLikes: 89,
              ),
              _buildPostCard(
                context,
                userName: 'Alexander Marcus',
                time: '2h ago',
                location: 'Tech Hub',
                content: 'Just launched the new Shrowd update! Check out the refined wire feed. @shrowd_app',
                imageCount: 0,
                ghostLikes: 432,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: FloatingActionButton(
            onPressed: () => PostComposer.show(context),
            backgroundColor: accentColor,
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          const Text(
            'Discover',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
          ),
          const SizedBox(width: 24),
          Text(
            'Following',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: secondaryTextColor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildStories(Color secondaryTextColor) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          _buildAddStory(secondaryTextColor),
          _buildStoryCard('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'),
          _buildStoryCard('https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200'),
          _buildStoryCard('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200'),
        ],
      ),
    );
  }

  Widget _buildAddStory(Color secondaryTextColor) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6366F1), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D0D12), width: 2),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Your Story', style: TextStyle(fontSize: 11, color: secondaryTextColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStoryCard(String imageUrl) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF00D6), Color(0xFF9D00FF), Color(0xFF00E5FF)],
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(height: 6),
          const Text('User', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRecentlyPostHeader(Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recent Posts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Icon(Icons.tune_rounded, color: secondaryTextColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildPostCard(
    BuildContext context, {
    required String userName,
    required String time,
    required String location,
    required String content,
    required int imageCount,
    required int ghostLikes,
    bool isWanderer = false,
  }) {
    final identity = Provider.of<IdentityService>(context, listen: false);
    final String displayName = isWanderer ? 'Wanderer#${math.Random().nextInt(999).toString().padLeft(3, '0')}' : userName;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: isWanderer
                    ? const NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png')
                    : NetworkImage('https://i.pravatar.cc/150?u=$userName'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(displayName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white)),
                        if (isWanderer) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.blur_on, color: Colors.white.withOpacity(0.5), size: 14),
                        ],
                      ],
                    ),
                    Text(
                      '$location • $time',
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.3)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5, fontWeight: FontWeight.w400),
          ),
          if (imageCount > 0) ...[
            const SizedBox(height: 16),
            _buildPostImages(imageCount),
          ],
          const SizedBox(height: 20),
          _buildInteractionBar(context, ghostLikes),
        ],
      ),
    );
  }

  Widget _buildPostImages(int count) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.unsplash.com/photo-1544441893-675973e31d85?w=800',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInteractionBar(BuildContext context, int ghostLikes) {
    return Row(
      children: [
        _buildGhostLikes(ghostLikes),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => CommentSheet.show(context),
          child: _buildInteractionItem(Icons.chat_bubble_outline_rounded, '24'),
        ),
        const Spacer(),
        _buildEmojiReactions(),
      ],
    );
  }

  Widget _buildGhostLikes(int count) {
    return Row(
      children: [
        const Icon(Icons.favorite_rounded, color: Color(0xFFFF3B30), size: 20),
        const SizedBox(width: 6),
        Text(
          '$count',
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 4),
        Text(
          'GHOST LIKES',
          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5),
        ),
      ],
    );
  }

  Widget _buildInteractionItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildEmojiReactions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          const Text('12', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          const Text('✨', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          const Text('8', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
