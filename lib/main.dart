import 'package:flutter/material.dart';

import './pages/products_overview_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  static const appTitle = "Shop";

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.blueGrey
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: theme,
      home: ProductsOverviewPage(),
    );
  }

}