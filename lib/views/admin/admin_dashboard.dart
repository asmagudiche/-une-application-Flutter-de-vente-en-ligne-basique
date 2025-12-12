// lib/views/admin/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title:
            const Text('Administration', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => context.read<AuthProvider>().logout(),
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
              'ESPACE ADMIN',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gestion complète de la plateforme e-commerce',
              style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
            ),
            const SizedBox(height: 30),

            // Grille des fonctionnalités
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.3,
                children: [
                  _buildAdminCard(
                    context,
                    icon: Icons.inventory_2_outlined,
                    title: 'CRUD Produits',
                    subtitle: 'Ajouter, modifier, supprimer',
                    color: Colors.orange,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProductsScreen())),
                  ),
                  _buildAdminCard(
                    context,
                    icon: Icons.bar_chart,
                    title: 'Suivi des stocks',
                    subtitle: 'Gestion du stock en temps réel',
                    color: Colors.green,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const StockScreen())),
                  ),
                  _buildAdminCard(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: 'Commandes',
                    subtitle: 'Toutes les commandes clients',
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OrdersScreen())),
                  ),
                  _buildAdminCard(
                    context,
                    icon: Icons.local_offer_outlined,
                    title: 'Promotions & Coupons',
                    subtitle: 'Créer des codes promo',
                    color: Colors.red,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PromoScreen())),
                  ),
                  _buildAdminCard(
                    context,
                    icon: Icons.analytics_outlined,
                    title: 'Statistiques',
                    subtitle: 'Produits les plus vendus',
                    color: Colors.purple,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const StatsScreen())),
                  ),
                  _buildAdminCard(
                    context,
                    icon: Icons.people_outline,
                    title: 'Clients',
                    subtitle: 'Gestion des utilisateurs',
                    color: Colors.teal,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ClientsScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 12,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(icon, size: 48, color: color),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Écrans temporaires (tu peux les remplacer plus tard)
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Gestion des produits - CRUD')));
}

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Suivi des stocks')));
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Liste des commandes')));
}

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Gestion des promotions')));
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Statistiques des ventes')));
}

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Liste des clients')));
}
