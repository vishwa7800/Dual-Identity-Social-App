import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/economy_service.dart';
import '../../widgets/shrowd_layout.dart';
import 'quest_board_screen.dart';

class QuestDetailsScreen extends StatefulWidget {
  final Quest quest;
  const QuestDetailsScreen({super.key, required this.quest});

  @override
  State<QuestDetailsScreen> createState() => _QuestDetailsScreenState();
}

class _QuestDetailsScreenState extends State<QuestDetailsScreen> {
  bool _isSubmitted = false;
  bool _isApproved = false;

  void _submitProof() {
    setState(() {
      _isSubmitted = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proof submitted successfully!')),
    );

    // Simulate creator review after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isApproved = true;
        });
        Provider.of<EconomyService>(context, listen: false).earnEssence('Quest: ${widget.quest.title}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF10B981),
            content: Text('Quest Approved! You earned ${widget.quest.reward}'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShrowdLayout(
      showTopToggle: false,
      child: Column(
        children: [
          _buildHero(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildInfoChip(Icons.person_outline, widget.quest.creator),
                      const SizedBox(width: 12),
                      _buildInfoChip(Icons.auto_awesome, widget.quest.reward, color: const Color(0xFF6366F1)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('THE PROMPT', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
                  const SizedBox(height: 12),
                  Text(
                    widget.quest.description,
                    style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
                  ),
                  const SizedBox(height: 40),
                  if (!_isSubmitted) _buildSubmitSection()
                  else if (!_isApproved) _buildPendingSection()
                  else _buildSuccessSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.quest.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, const Color(0xFF0D0D12).withOpacity(0.8), const Color(0xFF0D0D12)],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 24,
          child: Text(
            widget.quest.title,
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: (color ?? Colors.white).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (color ?? Colors.white).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color ?? Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color ?? Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSubmitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.none),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_outlined, color: Colors.white.withOpacity(0.3), size: 48),
              const SizedBox(height: 12),
              Text('Upload your proof photo', style: TextStyle(color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _submitProof,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('SUBMIT PROOF', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),
      ],
    );
  }

  Widget _buildPendingSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AWAITING REVIEW', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                Text('The creator is reviewing your submission.', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: Color(0xFF10B981), size: 32),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('QUEST COMPLETED', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                Text('1 Essence has been added to your wallet.', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
