import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {

  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsProvider.getProductCount,
          itemBuilder: (_, index) {
            return Column(
              children: [
                UserProductItem(productsProvider.getProducts[index])
              ]
            );
          }
        ),
      ),
    );
  }

}