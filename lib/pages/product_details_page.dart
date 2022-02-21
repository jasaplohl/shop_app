import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product name")),
    );
  }
}