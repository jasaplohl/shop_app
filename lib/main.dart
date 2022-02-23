import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';

import './pages/products_overview_page.dart';
import './pages/product_details_page.dart';
import './pages/cart_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  static const appTitle = "Shop";

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.blueGrey,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
    fontFamily: "Lato",
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white)
    )
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider())
      ],
      child: MaterialApp(
        title: appTitle,
        theme: theme,
        home: ProductsOverviewPage(),
        routes: {
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          CartPage.routeName:(context) => CartPage()
        },
      ),
    );
  }
}