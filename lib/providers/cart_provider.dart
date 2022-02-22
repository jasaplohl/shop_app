import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price, 
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get getItems {
    return {..._items};
  }

  int get getCartItemsNumber {
    return _items.length;
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
  }
}