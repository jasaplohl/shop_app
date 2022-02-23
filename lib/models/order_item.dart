import './cart_item_model.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cart;
  final DateTime timeStamp;

  OrderItem({
    required this.id,
    required this.amount,
    required this.cart,
    required this.timeStamp
  });
}