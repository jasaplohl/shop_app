import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get getItems {
    return {..._items};
  }

  int get getCount {
    return _items.length;
  }

  int get getInstanceCount {
    int sum = 0;
    _items.forEach((key, cartItem) {
      sum += cartItem.quantity;
    });
    return sum;
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

  void removeItemInstance(String productId) {
    if(!_items.containsKey(productId)) return;
    if(_items[productId]!.quantity > 1) {
      _items.update(productId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
          title: existingCartItem.title
        );
      });
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

}