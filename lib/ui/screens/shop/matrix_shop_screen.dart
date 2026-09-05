import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/economy_service.dart';
import '../../widgets/shrowd_layout.dart';

class ShopItem {
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  ShopItem({required this.name, required this.price, required this.category, required this.imageUrl});
}

class MatrixShopScreen extends StatelessWidget {
  MatrixShopScreen({super.key});

  final List<ShopItem> items = [
    ShopItem(
      name: 'Neon Halo',
      price: 5.0,
      category: 'AVATAR FX',
      imageUrl: 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=200',
    ),
    ShopItem(
      name: 'Glitch Border',
      price: 3.0,
      category: 'PROFILE FRAME',
      imageUrl: 'https://images.unsplash.com/photo-1614850523296-e8c041de4032?q=80&w=200',
    ),
    ShopItem(
      name: 'Void Essence',
      price: 10.0,
      category: 'BADGE',
      imageUrl: 'https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?q=80&w=200',
    ),
    ShopItem(
      name: 'Cyber Wings',
      price: 15.0,
      category: 'AVATAR FX',
      imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final economy = Provider.of<EconomyService>(context);

    return ShrowdLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('THE MATRIX', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 2)),
                    SizedBox(height: 4),
                    Text('Cosmetic Shop', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                _buildBalance(economy.essenceBalance),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => _buildItemCard(context, items[index], economy),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalance(double balance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFF00E5FF), size: 16),
          const SizedBox(width: 8),
          Text(
            '${balance.toStringAsFixed(1)} ESSENCE',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, ShopItem item, EconomyService economy) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(item.imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.category, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 9, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.price} E', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    _buildBuyButton(context, item, economy),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context, ShopItem item, EconomyService economy) {
    final bool canAfford = economy.essenceBalance >= item.price;
    return GestureDetector(
      onTap: canAfford ? () {
        if (economy.spendEssence('Purchased ${item.name}', item.price)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchased ${item.name}!')),
          );
        }
      } : null,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: canAfford ? const Color(0xFF00E5FF) : Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          canAfford ? Icons.shopping_cart_outlined : Icons.lock_outline,
          size: 16,
          color: canAfford ? Colors.black : Colors.white24,
        ),
      ),
    );
  }
}
