import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item_model.dart';

import '../providers/cart_provider.dart';

class CartListItem extends StatelessWidget {

  final String productId;
  final CartItem cartItem;

  const CartListItem(this.productId, this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(10),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      child: Card(
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
      ),
    );
  }

}