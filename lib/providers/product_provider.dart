// lib/providers/product_provider.dart
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _collection.get();
      _products = snapshot.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      if (kDebugMode) print("Erreur chargement produits : $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _collection.doc(product.id).set(product.toMap());
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _collection.doc(product.id).update(product.toMap());
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await _collection.doc(id).delete();
    await fetchProducts();
  }
}
