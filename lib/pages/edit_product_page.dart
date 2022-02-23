import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/products_provider.dart';

class EditProductPage extends StatefulWidget {

  static const routeName = "/edit-product";

  @override
  _EditProductPageState createState() => _EditProductPageState();
  
}

class _EditProductPageState extends State<EditProductPage> {

  final _form = GlobalKey<FormState>();

  ProductProvider _editedProduct = ProductProvider(
    id: null, 
    title: "", 
    description: "", 
    price: 0, 
    imageUrl: ""
  );

  bool _didInit = false;

  var _initValues = {
    'title': '',
    'description': '',
    'price': ''
  };

  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImagePreview);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_didInit) {
      final productProvider = ModalRoute.of(context)?.settings.arguments;
      
      if(productProvider != null) {
        _editedProduct = productProvider as ProductProvider;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString()
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _didInit = true;
    }
    
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImagePreview);

    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();

    _imageUrlController.dispose();

    super.dispose();
  }

  void _updateImagePreview() {
    if(!_imageUrlFocusNode.hasFocus) {
      if(_imageUrlController.text.isNotEmpty) {
        setState(() {});
      }
    }
  }

  void _saveForm(BuildContext context) {
    final bool isValid = _form.currentState!.validate();
    if(isValid) {
      _form.currentState!.save();

      if(_editedProduct.id == null) {
        Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
      } else {
        Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
        actions: [
          IconButton(
            onPressed: () => _saveForm(context), 
            icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                autofocus: true,
                decoration: const InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next, // Bottom right button on the keyboard -> next input field
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: _editedProduct.id,
                    title: value!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isFavourite: _editedProduct.isFavourite
                  );
                },
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Invalid title";
                  } else {
                    return null;
                  }
                }
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editedProduct.imageUrl,
                    isFavourite: _editedProduct.isFavourite
                  );
                },
                validator: (value) {
                  if(value!.isEmpty || (double.tryParse(value) == null)
                    || double.parse(value) <= 0
                  ) {
                    return "Invalid price.";
                  }
                  return null;
                }
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isFavourite: _editedProduct.isFavourite
                  );
                },
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Invalid description.";
                  }
                  return null;
                }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)
                    ),
                    child: _imageUrlController.text.isEmpty 
                      ? const Text("No image.")
                      : FittedBox(
                        child: Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState((){});
                      },
                      onFieldSubmitted: (_) {
                        _saveForm(context);
                      },
                      onSaved: (value) {
                        _editedProduct = ProductProvider(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value!,
                          isFavourite: _editedProduct.isFavourite
                        );
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "Invalid URL.";
                        }
                        return null;
                      }
                    )
                  )
                ],
              )
            ],
          )
        ),
      )
    );
  }
}