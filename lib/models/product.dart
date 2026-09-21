// lib/models/product.dart
// Data model that mirrors the "products" table returned by the backend API.

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final bool isExclusive;
  final bool isBestSelling;
  final bool isGrocery;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.isExclusive,
    required this.isBestSelling,
    required this.isGrocery,
    required this.stock,
  });

  // Converts the JSON map returned by the API into a Product instance.
  // Handles the fact that MySQL booleans/decimals may arrive as
  // int (0/1), bool, or string depending on the driver/serialization.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: _asInt(json['id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: _asDouble(json['price']),
      image: json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      isExclusive: _asBool(json['is_exclusive']),
      isBestSelling: _asBool(json['is_best_selling']),
      isGrocery: _asBool(json['is_grocery']),
      stock: _asInt(json['stock']),
    );
  }

  static int _asInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _asDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static bool _asBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value == 1;
    final str = value.toString().toLowerCase();
    return str == '1' || str == 'true';
  }
}
