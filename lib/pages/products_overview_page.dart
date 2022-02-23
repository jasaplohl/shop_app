import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart_provider.dart';

import '../pages/cart_page.dart';

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

  void onCartButtonClick(BuildContext context) {
    Navigator.of(context).pushNamed(CartPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cartProvider, child) {
              return Badge(
                value: cartProvider.getCount.toString(),
                child: child!
              );
            },
            child: IconButton(
              icon: const Icon(Icons.shopping_cart), 
              onPressed: () => onCartButtonClick(context)
            ),
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
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavourites),
    );
  }
}