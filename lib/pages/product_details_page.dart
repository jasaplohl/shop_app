import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)!.settings.arguments as String;
    final ProductProvider product = 
      Provider.of<ProductsProvider>(context, listen: false).getProductById(productId);
    
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text("\$${product.price}", style: const TextStyle(
              color: Colors.grey,
              fontSize: 20
            )),
            const SizedBox(height: 10),
            Text(product.description, textAlign: TextAlign.center, softWrap: true),
          ]
        )
      )
    );
  }
}