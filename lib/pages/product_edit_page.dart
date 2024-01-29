// lib/pages/product_edit_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductEditPage extends StatefulWidget {
  final int productId;

  const ProductEditPage({super.key, required this.productId});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController =
      TextEditingController(); // Yeni eklenen controller

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final response = await http.get(
        Uri.parse('http://localhost:5203/api/products/${widget.productId}'));
    if (response.statusCode == 200) {
      final product = Product.fromJson(json.decode(response.body));
      nameController.text = product.name;
      valueController.text = product.value.toString(); // Yeni eklenen satır
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Future<void> updateProduct() async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5203/api/products/${widget.productId}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': nameController.text,
          'value': int.parse(valueController.text),
        }),
      );

      if (response.statusCode == 200) {
        // Güncelleme başarılı
        // TODO: Geri dönüş ekranına yönlendirme
        Navigator.pop(context, true);
      } else {
        // Güncelleme başarısız
        throw Exception(
            'Failed to update product. Status Code: ${response.statusCode}, Response Body: ${response.body}');
      }
    } catch (error) {
      print('Update Product Error: $error');
      throw Exception('Failed to update product. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Product Value'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateProduct,
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final int value;

  Product({required this.id, required this.name, required this.value});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }
}
