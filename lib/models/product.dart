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
    this.stock = 999,
    this.isFeatured = false,
    this.discount,
  });

  double get finalPrice => discount != null ? price * (1 - discount!) : price;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
    bool? isFeatured,
    double? discount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      isFeatured: isFeatured ?? this.isFeatured,
      discount: discount ?? this.discount,
    );
  }
}
