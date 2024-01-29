// lib/services/product_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl;

  ProductService(this.baseUrl);

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/products'));

    if (response.statusCode == 200) {
      // API'den gelen veriyi parse et
      List<dynamic> data = json.decode(response.body);
      // Her bir veriyi Product nesnesine dönüştür
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      // Hata durumunda boş bir liste döndür
      return [];
    }
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime? deletedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.modifiedAt,
    this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['value'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
