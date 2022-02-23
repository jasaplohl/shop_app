import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

class CartPage extends StatelessWidget {

  static const routeName = "/cart";

  void placeOrder(CartProvider cartProvider, OrdersProvider ordersProvider) {
    ordersProvider.addOrder(
      cartProvider.getItems.values.toList(), 
      cartProvider.getTotalPrice
    );
    cartProvider.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total: "),
                    const SizedBox(width: 15),
                    Chip(
                      label: Text(
                        "\$ ${cartProvider.getTotalPrice}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    )
                  ]
                ),
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.getCount,
                itemBuilder: (context, index) {
                  return CartListItem(
                    cartProvider.getItems.keys.toList()[index],
                    cartProvider.getItems.values.toList()[index]
                  );
                },
              )
            ),
            TextButton(
              onPressed: (cartProvider.getCount > 0) ? 
                (() => placeOrder(cartProvider, ordersProvider)) : null, 
              child: const Text(
                "Place Order",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            )
          ],
        ),
      ),
    );
  }

}