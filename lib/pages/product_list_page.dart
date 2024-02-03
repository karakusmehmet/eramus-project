import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_api_app/pages/product_edit_page.dart';
import 'package:my_api_app/Models/product.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:5203/api/products'));
    if (response.statusCode == 200) {
      final List<Product> updatedProducts = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();

      setState(() {
        products = updatedProducts;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Text('id: ${product.id.toString()}'),
            title: Text('Name: ${product.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Value: ${product.value.toString()}'),
                Text('Created At: ${product.createdAt.toLocal()}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductEditPage(product: product),
                ),
              ).then((value) {
                if (value == true) {
                  fetchProducts();
                }
              });
            },
          );
        },
      ),
    );
  }
}
