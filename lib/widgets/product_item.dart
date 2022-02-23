import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/product_details_page.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

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

  SnackBar buildSnackbar(CartProvider cartProvider, ProductProvider productProvider) {
    return SnackBar(
      content: const Text("Product has been added to cart"),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: "Undo", 
        onPressed: () => cartProvider.removeItemInstance(productProvider.id)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen: false ensures that the widget doesn't rebuild if the item changes.
    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
    final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

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
          leading: Consumer<ProductProvider>( // We use consumer here, so that the entire item doesn't rebuild
            builder: (ctx, value, child) => IconButton(
              icon: getFavouriteIcon(productProvider.isFavourite), 
              color: Theme.of(context).colorScheme.secondary,
              onPressed: productProvider.toggleFavourite
            ),
          ),
          title: Text(productProvider.title, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart), 
            onPressed: () {
              cartProvider.addItem(productProvider.id, productProvider.price, productProvider.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(cartProvider, productProvider));
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ),
    );
  }

}