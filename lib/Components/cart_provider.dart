import 'package:flutter/material.dart';

class CartManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

   void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
    print("Products:$_cartItems");
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    print("Increasing quantity for item at index: $index");
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      final currentQuantity = _cartItems[index]['quantity'] ?? 0;
      if (currentQuantity > 1) {
        _cartItems[index]['quantity'] = currentQuantity - 1;
        notifyListeners();
      }
    }
  }
  double calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += (item['price'] ?? 0.0) * (item['quantity'] ?? 1);
    }
    return total;
  }

}
