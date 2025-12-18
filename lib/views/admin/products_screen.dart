// lib/views/admin/products_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import 'product_form_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;
        final isLoading = productProvider.isLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Gestion des Produits'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                tooltip: 'Ajouter un produit',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProductFormScreen()),
                  );
                },
              ),
            ],
          ),
          // BOUTON FLOTTANT "AJOUTER PRODUIT" (comme demandé)
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormScreen()),
              );
            },
            backgroundColor: Colors.indigo,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Ajouter produit',
                style: TextStyle(color: Colors.white)),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 100, color: Colors.grey[400]),
                          const SizedBox(height: 20),
                          const Text('Aucun produit',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.grey)),
                          const SizedBox(height: 10),
                          const Text(
                              'Appuyez sur le bouton + pour ajouter votre premier produit'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          elevation: 8,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${product.finalPrice.toStringAsFixed(0)} €'),
                                Text('Stock: ${product.stock}',
                                    style: TextStyle(
                                        color: product.stock > 0
                                            ? Colors.green
                                            : Colors.red)),
                                if (product.isFeatured)
                                  const Chip(
                                    label: Text('Produit vedette',
                                        style: TextStyle(fontSize: 12)),
                                    backgroundColor: Colors.amber,
                                  ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductFormScreen(product: product),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    productProvider.deleteProduct(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('${product.name} supprimé')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
