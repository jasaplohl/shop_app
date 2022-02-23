import 'package:flutter/material.dart';

import '../providers/product_provider.dart';

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

  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImagePreview);

    super.initState();
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

  void _saveForm() {
    final bool isValid = _form.currentState!.validate();
    if(isValid) {
      _form.currentState!.save();
      print(_editedProduct.title);
      print(_editedProduct.description);
      print(_editedProduct.price);
      print(_editedProduct.imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
        actions: [
          IconButton(
            onPressed: _saveForm, 
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
                autofocus: true,
                decoration: const InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next, // Bottom right button on the keyboard -> next input field
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: null,
                    title: value!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
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
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editedProduct.imageUrl,
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
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = ProductProvider(
                    id: null,
                    title: _editedProduct.title,
                    description: value!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
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
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = ProductProvider(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value!,
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