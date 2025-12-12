import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(
        id: '1',
        name: 'iPhone 15',
        description: '128Go Noir',
        price: 899,
        imageUrl:
            'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-family-select-2023?wid=256&hei=256&fmt=jpeg',
        isFeatured: true,
        discount: 0.15),
    Product(
        id: '2',
        name: 'MacBook Air M2',
        description: '256Go',
        price: 1299,
        imageUrl:
            'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mba13-midnight-select-202402?wid=256&hei=256&fmt=jpeg',
        discount: 0.10),
    Product(
        id: '3',
        name: 'AirPods Pro',
        description: '2ème génération',
        price: 279,
        imageUrl:
            'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQD83?wid=256&hei=256&fmt=jpeg'),
    // Ajoute-en 6-8 autres produits si tu veux
  ];

  List<Product> get products => _products;
  List<Product> get featured => _products.where((p) => p.isFeatured).toList();

  void addProduct(Product p) {
    _products
        .add(p.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString()));
    notifyListeners();
  }

  void updateProduct(Product p) {
    final index = _products.indexWhere((prod) => prod.id == p.id);
    if (index != -1) {
      _products[index] = p;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
