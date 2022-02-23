import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get getItems {
    return {..._items};
  }

  int get getCount {
    return _items.length;
  }

  double get getTotalPrice {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if(_items.containsKey(productId)) {
      _items.update(productId, (previousCartItem) {
        CartItem cartItem = CartItem(
          id: previousCartItem.id, 
          title: previousCartItem.title, 
          quantity: previousCartItem.quantity + 1, 
          price: previousCartItem.price
        );
        return cartItem;
      });
    } else {
      CartItem cartItem = CartItem(
        id: const Uuid().v4(), 
        title: title, 
        quantity: 1, 
        price: price
      );
      _items.putIfAbsent(productId, () => cartItem);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

}