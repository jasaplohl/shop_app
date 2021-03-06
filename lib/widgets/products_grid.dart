import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';

import '../providers/products_provider.dart';
import '../providers/product_provider.dart';

class ProductsGrid extends StatelessWidget {

  final bool _showFavourites;

  const ProductsGrid(this._showFavourites);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);

    final List<ProductProvider> products = 
        _showFavourites ? productsProvider.getFavourites : productsProvider.getProducts;

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
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      }
    );
  }

}