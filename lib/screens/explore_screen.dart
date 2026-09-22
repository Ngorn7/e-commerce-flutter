
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';
import 'category_detail_screen.dart';
import 'shop_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<Product>> _exclusiveFuture;
  late Future<List<Product>> _bestSellingFuture;
  late Future<List<Product>> _groceryFuture;

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'Fruits', 'icon': Icons.apple},
    {'name': 'Vegetables', 'icon': Icons.eco_outlined},
    {'name': 'Dairy', 'icon': Icons.icecream_outlined},
    {'name': 'Bakery', 'icon': Icons.bakery_dining_outlined},
    {'name': 'Drinks', 'icon': Icons.local_drink_outlined},
    {'name': 'Snacks', 'icon': Icons.cookie_outlined},
  ];

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

  Future<void> _refresh() async {
    setState(_loadData);
    await Future.wait([_exclusiveFuture, _bestSellingFuture, _groceryFuture])
        .catchError((_) => <List<Product>>[]);
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryDetailScreen(category: category),
      ),
    );
  }

  void _goToShop() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        color: AppColors.primary,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildCategories(),
            const SizedBox(height: 28),
            SectionHeader(title: 'Exclusive Offers', onSeeAll: _goToShop),
            const SizedBox(height: 12),
            _buildProductSection(_exclusiveFuture),
            const SizedBox(height: 28),
            SectionHeader(title: 'Best Selling', onSeeAll: _goToShop),
            const SizedBox(height: 12),
            _buildProductSection(_bestSellingFuture),
            const SizedBox(height: 28),
            SectionHeader(title: 'Grocery', onSeeAll: _goToShop),
            const SizedBox(height: 12),
            _buildProductSection(_groceryFuture),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('E-Store',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                ),
                const SizedBox(height: 10),
                // Row(
                //   children: const [
                //     Icon(Icons.location_on_outlined,
                //         size: 16, color: AppColors.primary),
                //     SizedBox(width: 4),
                //     Text(
                //       'Phnom Penh, Cambodia',
                //       style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.notifications_none_rounded,
                color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryCard(
            name: category['name'],
            icon: category['icon'],
            onTap: () => _openCategory(category['name']),
          );
        },
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
