import 'package:flutter/material.dart';

import '../pages/product_details_page.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {

  final Product product;

  ProductItem(this.product);

  void onProductClick(BuildContext context) {
    Navigator.of(context).pushNamed(ProductDetailsPage.routeName, arguments: product.id);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => onProductClick(context),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          )
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(Icons.favorite), 
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {}
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart), 
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ),
    );
  }

}