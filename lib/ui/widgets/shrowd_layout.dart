import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/identity_service.dart';

import '../screens/wire/wire_feed_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/messages/inbox_screen.dart';
import '../screens/hubs/hub_list_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/quests/quest_board_screen.dart';

class ShrowdLayout extends StatelessWidget {
  final Widget child;
  final bool showTopToggle;
  final bool showBottomNav;
  final int selectedNavIndex;

  const ShrowdLayout({
    super.key,
    required this.child,
    this.showTopToggle = true,
    this.showBottomNav = true,
    this.selectedNavIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D12),
      body: Stack(
        children: [
          Column(
            children: [
              if (showTopToggle) _buildTopNav(context),
              Expanded(child: child),
            ],
          ),
          if (showBottomNav) _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildTopNav(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            _buildIdentityToggle(identity),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
              child: _buildProfileIndicator(identity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentityToggle(IdentityService identity) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleOption(
            'PUBLIC', 
            identity.isPublic, 
            () => identity.setIdentity(IdentityMode.public)
          ),
          _buildToggleOption(
            'WANDERER', 
            identity.isWanderer, 
            () => identity.setIdentity(IdentityMode.wanderer)
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white.withOpacity(0.4),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIndicator(IdentityService identity) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: identity.isWanderer ? Colors.white.withOpacity(0.2) : const Color(0xFF6366F1), width: 1.5),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(identity.activeAvatar),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WireFeedScreen())),
                    child: _buildNavItem(Icons.bolt_rounded, isSelected: selectedNavIndex == 0),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                    child: _buildNavItem(Icons.search_rounded, isSelected: selectedNavIndex == 1),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HubListScreen())),
                    child: _buildHubIcon(isSelected: selectedNavIndex == 2),
                  ),
                  // Message Icon (Disabled in Wanderer Mode)
                  GestureDetector(
                    onTap: identity.isPublic 
                      ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InboxScreen()))
                      : null,
                    child: Opacity(
                      opacity: identity.isPublic ? 1.0 : 0.3,
                      child: _buildNavItem(Icons.send_rounded, isSelected: selectedNavIndex == 3),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => QuestBoardScreen())),
                    child: _buildNavItem(Icons.group_outlined, isSelected: selectedNavIndex == 4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isSelected = false}) {
    return Icon(
      icon,
      color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
      size: 28,
    );
  }

  Widget _buildHubIcon({bool isSelected = false}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isSelected 
          ? const LinearGradient(
              colors: [Color(0xFFFF00D6), Color(0xFF9D00FF), Color(0xFF00E5FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
        color: isSelected ? null : Colors.white.withOpacity(0.05),
        boxShadow: isSelected ? [
          BoxShadow(
            color: const Color(0xFF9D00FF).withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ] : null,
        border: !isSelected ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
      ),
      child: Icon(Icons.hub_outlined, color: isSelected ? Colors.white : Colors.white.withOpacity(0.5), size: 26),
    );
  }
}
