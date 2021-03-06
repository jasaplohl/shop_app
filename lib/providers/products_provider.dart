import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'product_provider.dart';

class ProductsProvider with ChangeNotifier {

  final List<ProductProvider> _products = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    )
  ];

  int get getProductCount {
    return _products.length;
  }

  // We do not return the actual _products property
  // because we do not want it to be changed elsewhere.
  List<ProductProvider> get getProducts {
    return [..._products];
  }

  List<ProductProvider> get getFavourites {
    return _products.where((product) => product.isFavourite).toList();
  }

  ProductProvider getProductById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  void addProduct(ProductProvider product) {
    final ProductProvider newProduct = ProductProvider(
      id: const Uuid().v4(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl
    );
    
    _products.add(newProduct);
    notifyListeners();
  }

  void updateProduct(ProductProvider product) {
    final productIndex = _products.indexWhere((element) => element.id == product.id);
    if(productIndex >= 0) {
      _products[productIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

}