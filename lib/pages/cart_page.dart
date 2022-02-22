import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              elevation: 5,
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
            )
          ],
        ),
      ),
    );
  }

}