import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';

class CartListItem extends StatelessWidget {

  final CartItem cartItem;

  const CartListItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(
                child: Text("\$${cartItem.price}")
              ),
            )
          ),
          title: Text(cartItem.title),
          subtitle: Text("Total: ${cartItem.quantity * cartItem.price}"),
          trailing: Text("${cartItem.quantity} x")
        ),
      ),
    );
  }

}