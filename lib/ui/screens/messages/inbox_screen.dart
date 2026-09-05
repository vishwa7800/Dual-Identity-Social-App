import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/identity_service.dart';
import '../../widgets/shrowd_layout.dart';
import 'chat_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final identity = Provider.of<IdentityService>(context);

    // DMs are only for Public identity
    if (!identity.isPublic) {
      return const ShrowdLayout(
        child: Center(
          child: Text('DMs are only available in Public mode.', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return ShrowdLayout(
      showTopToggle: true,
      selectedNavIndex: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('MESSAGES', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildChatTile(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, int index) {
    final names = ['Sarah Connor', 'John Doe', 'Elena Fisher', 'Victor Sullivan', 'Nathan Drake'];
    final messages = ['Hey! Did you see the new Hub?', 'The project is looking great.', 'See you at the session.', 'Got the Essence, thanks!', 'Where are you?'];
    
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(userName: names[index]))),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$index'),
      ),
      title: Text(names[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(messages[index], style: TextStyle(color: Colors.white.withOpacity(0.5))),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('12:45 PM', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle),
            child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
