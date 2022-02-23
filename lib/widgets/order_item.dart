import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:math';

import '../models/order_item.dart';

class OrderListItem extends StatefulWidget {

  final OrderItem order;

  const OrderListItem(this.order);

  @override
  _OrderListItemState createState() => _OrderListItemState();

}

class _OrderListItemState extends State<OrderListItem> {

  bool _expanded = false;

  double getContentHeight(int length) {
    return length * 20 + 20;
  }

  void toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            subtitle: Text(DateFormat("dd. MM. yyyy").format(widget.order.timeStamp)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: toggleExpanded,
            ),
          ),
          if(_expanded) Container(
            height: min(getContentHeight(widget.order.cart.length), 100),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 7
            ),
            child: ListView(
              children: [
                ...widget.order.cart.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title, 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        "${product.quantity} x \$${product.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey
                        ),
                      )
                    ],
                  );
                })
              ]
            ),
          )
        ],
      ),
    );
  }
}