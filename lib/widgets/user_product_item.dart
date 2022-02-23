import 'package:flutter/material.dart';

import '../providers/product_provider.dart';

import '../pages/edit_product_page.dart';

class UserProductItem extends StatelessWidget {

  final ProductProvider productProvider;

  UserProductItem(this.productProvider);

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
              onPressed: (){}, 
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor
            )
          ],
        ),
      )
    );
  }

}