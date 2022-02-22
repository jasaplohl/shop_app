import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)!.settings.arguments as String;

    // Listen: false ensures that the widget doesn't rebuild if the item changes.
    // Default value = listen: true
    final ProductProvider product = Provider.of<ProductsProvider>(context, listen: false).getProductById(productId);
    
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Text(product.description),
        ]
      ),
    );
  }
}