// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(
      0, (sum, item) => sum + (item.product.finalPrice * item.quantity));

  void addItem(Product product) {
    final existing =
        _items.where((item) => item.product.id == product.id).firstOrNull;
    if (existing != null) {
      existing.quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    final existing =
        _items.where((item) => item.product.id == productId).firstOrNull;
    if (existing != null) {
      if (existing.quantity > 1) {
        existing.quantity--;
      } else {
        _items.remove(existing);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
