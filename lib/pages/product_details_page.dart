import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context).getProductWithId(productId);
    
    return Scaffold(
      appBar: AppBar(title: Text("Product name")),
      body: Column(
        children: [
          Text(product.title),
          Text(product.description),
        ]
      ),
    );
  }
}