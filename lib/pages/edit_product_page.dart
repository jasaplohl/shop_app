import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {

  static const routeName = "/edit-product";

  @override
  _EditProductPageState createState() => _EditProductPageState();
  
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit product")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                // Bottom right button on the keyboard -> next input field
                textInputAction: TextInputAction.next
              )
            ],
          )
        ),
      )
    );
  }
}