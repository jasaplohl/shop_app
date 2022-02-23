import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/products_provider.dart';

import '../pages/edit_product_page.dart';

class UserProductItem extends StatelessWidget {

  final ProductProvider productProvider;

  const UserProductItem(this.productProvider);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productProvider.imageUrl),
      ),
      title: Text(productProvider.title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductPage.routeName, arguments: productProvider);
              }, 
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor
            ), 
            IconButton(
              onPressed: (){
                Provider.of<ProductsProvider>(context, listen: false).deleteProduct(productProvider.id!);
              }, 
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor
            )
          ],
        ),
      )
    );
  }

}