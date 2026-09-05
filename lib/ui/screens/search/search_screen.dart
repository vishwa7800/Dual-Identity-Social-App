import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/identity_service.dart';
import '../../../services/follow_service.dart';
import '../../widgets/shrowd_layout.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  final List<Map<String, String>> _mockPublicProfiles = [
    {'id': '1', 'name': 'Sarah Connor', 'handle': '@sarah_c', 'avatar': 'https://i.pravatar.cc/150?u=1'},
    {'id': '2', 'name': 'John Doe', 'handle': '@jdoe', 'avatar': 'https://i.pravatar.cc/150?u=2'},
    {'id': '3', 'name': 'Elena Fisher', 'handle': '@elena_f', 'avatar': 'https://i.pravatar.cc/150?u=3'},
    {'id': '4', 'name': 'Victor Sullivan', 'handle': '@sully', 'avatar': 'https://i.pravatar.cc/150?u=4'},
  ];

  @override
  Widget build(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);
    final followService = Provider.of<FollowService>(context);

    return ShrowdLayout(
      showTopToggle: true,
      selectedNavIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF16161E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Public Profiles...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _mockPublicProfiles.length,
                itemBuilder: (context, index) {
                  final profile = _mockPublicProfiles[index];
                  final bool isFollowing = followService.isFollowing(profile['id']!, identity.isPublic);

                  return _buildProfileItem(profile, isFollowing, identity, followService);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(Map<String, String> profile, bool isFollowing, IdentityService identity, FollowService followService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(profile['avatar']!),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile['name']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  profile['handle']!,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => followService.toggleFollow(profile['id']!, identity.isPublic),
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.transparent : const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isFollowing ? BorderSide(color: Colors.white.withOpacity(0.2)) : BorderSide.none,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isFollowing ? Colors.white.withOpacity(0.6) : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
