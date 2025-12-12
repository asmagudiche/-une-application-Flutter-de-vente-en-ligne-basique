// lib/views/client/orders_screen.dart
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulation de commandes (tu pourras remplacer par Firebase plus tard)
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'CMD001',
        'date': '12 Déc 2025',
        'total': 129.99,
        'status': 'Livrée',
        'color': Colors.green,
        'items': 3,
      },
      {
        'id': 'CMD002',
        'date': '10 Déc 2025',
        'total': 89.50,
        'status': 'En cours',
        'color': Colors.orange,
        'items': 2,
      },
      {
        'id': 'CMD003',
        'date': '08 Déc 2025',
        'total': 199.00,
        'status': 'En préparation',
        'color': Colors.blue,
        'items': 5,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Commandes'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text('Aucune commande',
                      style: TextStyle(fontSize: 24, color: Colors.grey)),
                  SizedBox(height: 10),
                  Text('Commencez vos achats !'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: order['color'],
                      child: Text(
                        order['items'].toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text('Commande #${order['id']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date : ${order['date']}'),
                        Text(
                            '${order['items']} article${order['items'] > 1 ? 's' : ''}'),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${order['total'].toStringAsFixed(2)} €',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Chip(
                          label: Text(order['status'],
                              style: const TextStyle(fontSize: 12)),
                          backgroundColor: order['color'].withOpacity(0.2),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Détail de la commande (bonus)
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Commande #${order['id']}'),
                          content: Text(
                              'Statut : ${order['status']}\nTotal : ${order['total'].toStringAsFixed(2)} €'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Fermer')),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
