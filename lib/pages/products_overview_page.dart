import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

import '../providers/cart_provider.dart';

enum FilterOptions {
  favourites,
  all
}

class ProductsOverviewPage extends StatefulWidget {

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();

}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {

  bool _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Badge(
            value: cartProvider.getCartItemsNumber.toString(),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart), 
              onPressed: () {}
            )
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions option) {
              setState(() {
                _showFavourites = (option == FilterOptions.favourites) ? true : false;
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text("Favourites"), 
                value: FilterOptions.favourites
              ),
              PopupMenuItem(
                child: Text("Show All"), 
                value: FilterOptions.all
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavourites),
    );
  }
}