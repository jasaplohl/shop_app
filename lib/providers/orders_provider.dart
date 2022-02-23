import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/order_item.dart';
import '../models/cart_item_model.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    OrderItem order = OrderItem(
      id: const Uuid().v4(), 
      amount: total, 
      cart: cartItems, 
      timeStamp: DateTime.now()
    );
    _orders.insert(0, order);

    notifyListeners();
  }

}