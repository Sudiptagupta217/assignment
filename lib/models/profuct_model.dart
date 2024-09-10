// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      description: json['description'],
    );
  }
}
