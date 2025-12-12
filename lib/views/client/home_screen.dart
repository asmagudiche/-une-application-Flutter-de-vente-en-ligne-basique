// lib/views/client/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'stock_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title:
            const Text('Espace Client', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartScreen())),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Text(cart.itemCount.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre principal
            const Text(
              'Bienvenue !',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 8),
            Text(
              'Que souhaitez-vous faire aujourd’hui ?',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 40),

            // 3 BOUTONS PRINCIPAUX (conforme au cahier des charges)
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                mainAxisSpacing: 20,
                children: [
                  // BOUTON PANIER
                  _actionButton(
                    context,
                    icon: Icons.shopping_cart_outlined,
                    title: 'Mon Panier',
                    subtitle:
                        '${cart.itemCount} article${cart.itemCount > 1 ? 's' : ''} • ${cart.totalAmount.toStringAsFixed(0)} €',
                    color: Colors.green,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CartScreen())),
                  ),

                  // BOUTON COMMANDES
                  _actionButton(
                    context,
                    icon: Icons.receipt_long_outlined,
                    title: 'Mes Commandes',
                    subtitle: 'Voir l’historique et le suivi',
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OrdersScreen())),
                  ),

                  // BOUTON STOCK / PRODUITS
                  _actionButton(
                    context,
                    icon: Icons.inventory_2_outlined,
                    title: 'Parcourir les Produits',
                    subtitle: 'Voir le catalogue complet',
                    color: Colors.orange,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const StockScreen())),
                  ),
                ],
              ),
            ),

            // Bonus : message du jour
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.local_offer, size: 40, color: Colors.indigo),
                  SizedBox(height: 10),
                  Text('-30% sur tout le site !',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo)),
                  Text('Code : BIENVENUE30',
                      style: TextStyle(color: Colors.indigo)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton réutilisable magnifique
  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
