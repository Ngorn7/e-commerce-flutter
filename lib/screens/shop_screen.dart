// lib/screens/shop_screen.dart
// Shop tab: a search bar plus the same three product sections as Explore,
// using reusable widgets and the shared ApiService.

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<Product>> _exclusiveFuture;
  late Future<List<Product>> _bestSellingFuture;
  late Future<List<Product>> _groceryFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _exclusiveFuture = _apiService.getExclusiveProducts();
    _bestSellingFuture = _apiService.getBestSellingProducts();
    _groceryFuture = _apiService.getGroceryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SectionHeader(title: 'Exclusive Offers', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildProductSection(_exclusiveFuture),
            const SizedBox(height: 28),
            SectionHeader(title: 'Best Selling', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildProductSection(_bestSellingFuture),
            const SizedBox(height: 28),
            SectionHeader(title: 'Grocery', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildProductSection(_groceryFuture),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection(Future<List<Product>> future) {
    return SizedBox(
      height: 245,
      child: FutureBuilder<List<Product>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(onRetry: () => setState(_loadData));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const EmptyView();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: ProductCard(product: products[index]),
              );
            },
          );
        },
      ),
    );
  }
}
