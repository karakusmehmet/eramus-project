// lib/models/product.dart

class Product {
  final int id;
  final String name;
  final int value;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
