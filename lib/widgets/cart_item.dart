import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';

import '../providers/cart_provider.dart';

class CartListItem extends StatelessWidget {

  final String productId;
  final CartItem cartItem;

  const CartListItem(this.productId, this.cartItem);

  Future<bool> confirmDismiss(DismissDirection direction, BuildContext context) async {
    bool remove = false;
    await showDialog(
      context: context, 
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Delete from the cart."),
          content: const Text("Are you sure you want to remove the product from the cart?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("No")
            ),
            TextButton(
              onPressed: (){
                remove = true;
                Navigator.of(ctx).pop();
              }, 
              child: const Text("Yes")
            )
          ],
        );
      }
    );
    return remove;
  }

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
      confirmDismiss: (direction) => confirmDismiss(direction, context),
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
                  child: Text("\$${cartItem.price.toStringAsFixed(2)}")
                ),
              )
            ),
            title: Text(cartItem.title),
            subtitle: Text("Total: ${(cartItem.quantity * cartItem.price).toStringAsFixed(2)}"),
            trailing: Text("${cartItem.quantity} x")
          ),
        ),
      ),
    );
  }

}