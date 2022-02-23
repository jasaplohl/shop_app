import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatelessWidget {

  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersProvider.getOrders.length,
        itemBuilder: (context, index) {
          return OrderListItem(ordersProvider.getOrders[index]);
        },
      )
    );
  }
}