// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final bool isFeatured;
  final double? discount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    this.isFeatured = false,
    this.discount,
  });

  double get finalPrice => discount != null ? price * (1 - discount!) : price;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'isFeatured': isFeatured,
      'discount': discount,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      stock: map['stock'] ?? 0,
      isFeatured: map['isFeatured'] ?? false,
      discount: map['discount']?.toDouble(),
    );
  }
}
