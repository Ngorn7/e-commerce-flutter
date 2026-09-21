// lib/services/api_service.dart
// Single place where all HTTP calls to the Node.js backend live.
// UI widgets/screens should never call `http` directly — they call
// these methods instead.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ApiService {
  // --- Base URL configuration -------------------------------------------
  // Android Emulator maps 10.0.2.2 to the host machine's localhost.
  // - Android Emulator  -> http://10.0.2.2:5000/api
  // - iOS Simulator     -> http://localhost:5000/api
  // - Web Browser       -> http://localhost:5000/api
  // - Physical device   -> http://<your-computer-LAN-IP>:5000/api
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000/api';
    }
    return 'http://10.0.2.2:5000/api';
  }

  // Generic helper that performs a GET request and returns the decoded
  // JSON body, throwing a readable exception on failure.
  Future<dynamic> _get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http
          .get(uri, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 15));

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        return body['data'];
      }

      // Server responded but with an error (e.g. 404 product not found)
      throw Exception(body['message'] ?? 'Something went wrong');
    } on http.ClientException {
      throw Exception('Could not reach the server. Please try again.');
    } on FormatException {
      throw Exception('Received an invalid response from the server.');
    }
  }

  /// GET /api/products
  Future<List<Product>> getProducts() async {
    final data = await _get('/products');
    return (data as List).map((item) => Product.fromJson(item)).toList();
  }

  /// GET /api/products?id=ID
  Future<Product> getProduct(int id) async {
    final data = await _get('/products?id=$id');
    return Product.fromJson(data as Map<String, dynamic>);
  }

  /// GET /api/products/exclusive
  Future<List<Product>> getExclusiveProducts() async {
    final data = await _get('/products/exclusive');
    return (data as List).map((item) => Product.fromJson(item)).toList();
  }

  /// GET /api/products/best-selling
  Future<List<Product>> getBestSellingProducts() async {
    final data = await _get('/products/best-selling');
    return (data as List).map((item) => Product.fromJson(item)).toList();
  }

  /// GET /api/grocery
  Future<List<Product>> getGroceryProducts() async {
    final data = await _get('/grocery');
    return (data as List).map((item) => Product.fromJson(item)).toList();
  }

  /// GET /api/products/category/CATEGORY
  /// Used by the Category Detail screen to filter products.
  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await _get('/products/category/$category');
    return (data as List).map((item) => Product.fromJson(item)).toList();
  }
}
