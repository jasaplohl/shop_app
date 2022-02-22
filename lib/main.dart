import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';

import './pages/products_overview_page.dart';
import './pages/product_details_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  static const appTitle = "Shop";

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.blueGrey,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
    fontFamily: "Lato"
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: appTitle,
        theme: theme,
        home: ProductsOverviewPage(),
        routes: {
          ProductDetailsPage.routeName: (context) => ProductDetailsPage()
        },
      ),
    );
  }

}