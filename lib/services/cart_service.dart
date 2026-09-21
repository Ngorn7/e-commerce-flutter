import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartService {
  // Singleton pattern so the cart state is shared across the app
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // ValueNotifier alerts the UI to rebuild when the list changes
  final ValueNotifier<List<CartItem>> items = ValueNotifier([]);

  void addToCart(Product product, [int quantity = 1]) {
    final List<CartItem> currentList = List.from(items.value);
    final existingIndex = currentList.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      currentList[existingIndex].quantity += quantity;
    } else {
      currentList.add(CartItem(product: product, quantity: quantity));
    }
    
    // Assigning a new list forces ValueNotifier to notify listeners
    items.value = currentList;
  }
  
  void removeFromCart(int productId) {
    items.value = items.value.where((item) => item.product.id != productId).toList();
  }
  
  void clear() {
    items.value = [];
  }
  
  double get total => items.value.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
