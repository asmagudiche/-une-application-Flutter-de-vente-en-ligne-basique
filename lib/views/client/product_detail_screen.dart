// lib/views/client/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(product.imageUrl,
                height: 300, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  if (product.discount != null && product.discount! > 0) ...[
                    Text('${product.price.toStringAsFixed(0)} €',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey)),
                    Text('${product.finalPrice.toStringAsFixed(0)} €',
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
                  ] else
                    Text('${product.price.toStringAsFixed(0)} €',
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(product.description,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Text('Stock disponible : ${product.stock}',
                      style: TextStyle(
                          color:
                              product.stock > 0 ? Colors.green : Colors.red)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo),
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Ajouter au panier',
                          style: TextStyle(fontSize: 18)),
                      onPressed: product.stock > 0
                          ? () {
                              cart.addItem(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${product.name} ajouté !'),
                                    backgroundColor: Colors.green),
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
