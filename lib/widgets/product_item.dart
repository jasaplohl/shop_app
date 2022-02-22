import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/product_details_page.dart';

import '../providers/product_provider.dart';

class ProductItem extends StatelessWidget {

  void onProductClick(BuildContext context, id) {
    Navigator.of(context).pushNamed(ProductDetailsPage.routeName, arguments: id);
  }

  Icon getFavouriteIcon(bool isFavourite) {
    if(isFavourite) {
      return const Icon(Icons.favorite);
    } else {
      return const Icon(Icons.favorite_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => onProductClick(context, productProvider.id),
          child: Image.network(
            productProvider.imageUrl,
            fit: BoxFit.cover,
          )
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: getFavouriteIcon(productProvider.isFavourite), 
            color: Theme.of(context).colorScheme.secondary,
            onPressed: productProvider.toggleFavourite
          ),
          title: Text(productProvider.title, textAlign: TextAlign.center),
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