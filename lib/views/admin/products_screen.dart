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
            actions: [
              IconButton(
                icon: const Icon(Icons.add_box),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProductFormScreen())),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.indigo,
            icon: const Icon(Icons.add),
            label: const Text('Nouveau produit'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProductFormScreen())),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : products.isEmpty
                  ? const Center(
                      child: Text('Aucun produit\nCliquez sur + pour ajouter',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              product.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image),
                            ),
                            title: Text(product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                '${product.finalPrice.toStringAsFixed(0)} € • Stock: ${product.stock}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductFormScreen(
                                                product: product),
                                          ));
                                    }),
                                IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      productProvider.deleteProduct(product.id);
                                    }),
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
