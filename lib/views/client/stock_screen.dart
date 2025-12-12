// lib/views/client/stock_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import 'product_detail_screen.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue Produits'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: products.isEmpty
          ? const Center(child: Text('Aucun produit disponible'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            product.imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1),
                              const SizedBox(height: 4),
                              Text('${product.finalPrice.toStringAsFixed(0)} €',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Text('Stock: ${product.stock}',
                                  style: TextStyle(
                                      color: product.stock > 0
                                          ? Colors.green
                                          : Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
