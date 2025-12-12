// lib/views/client/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mon Panier')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.network(item.product.imageUrl,
                            width: 60, height: 60, fit: BoxFit.cover),
                        title: Text(item.product.name),
                        subtitle: Text(
                            '${item.product.finalPrice.toStringAsFixed(0)} € × ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    cart.removeItem(item.product.id)),
                            Text('${item.quantity}'),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => cart.addItem(item.product)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border:
                          Border(top: BorderSide(color: Colors.grey[300]!))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('${cart.totalAmount.toStringAsFixed(0)} €',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.all(16)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Commande passée avec succès !')));
                            cart.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('Passer la commande',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
