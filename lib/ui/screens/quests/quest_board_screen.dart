import 'package:flutter/material.dart';
import '../../widgets/shrowd_layout.dart';
import 'quest_details_screen.dart';

class Quest {
  final String id;
  final String title;
  final String creator;
  final String reward;
  final String description;
  final String imageUrl;

  Quest({
    required this.id,
    required this.title,
    required this.creator,
    required this.reward,
    required this.description,
    required this.imageUrl,
  });
}

class QuestBoardScreen extends StatelessWidget {
  QuestBoardScreen({super.key});

  final List<Quest> quests = [
    Quest(
      id: '1',
      title: 'Neon Night Photography',
      creator: 'VaporWave#99',
      reward: '1 Essence',
      description: 'Capture the soul of the city after midnight. High contrast, neon lights only.',
      imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?q=80&w=1000',
    ),
    Quest(
      id: '2',
      title: 'The Hidden Alley',
      creator: 'ShadowWalker',
      reward: '1 Essence',
      description: 'Find and photograph a hidden alleyway in your district that feels like another world.',
      imageUrl: 'https://images.unsplash.com/photo-1533929736458-ca588d08c8be?q=80&w=1000',
    ),
    Quest(
      id: '3',
      title: 'Cyberpunk Coffee',
      creator: 'GlitchArt',
      reward: '1 Essence',
      description: 'A photo of your morning coffee in a futuristic or industrial setting.',
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=1000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ShrowdLayout(
      selectedNavIndex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('QUEST BOARD', style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 2)),
                    SizedBox(height: 4),
                    Text('Community Challenges', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                _buildPostQuestButton(context),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: quests.length,
              itemBuilder: (context, index) {
                return _buildQuestCard(context, quests[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostQuestButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implementation for posting quest would go here
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
        ),
        child: const Icon(Icons.add, color: Color(0xFF6366F1)),
      ),
    );
  }

  Widget _buildQuestCard(BuildContext context, Quest quest) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuestDetailsScreen(quest: quest))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(quest.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(4)),
                    child: Text(quest.reward, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Text('by ${quest.creator}', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 8),
              Text(quest.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
