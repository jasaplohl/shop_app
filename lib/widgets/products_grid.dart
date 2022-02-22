import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';

import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).getProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(10), 
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), 
      itemBuilder: (context, index) {
        return ProductItem(products[index]);
      }
    );
  }

}