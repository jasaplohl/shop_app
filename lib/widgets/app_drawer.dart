import 'package:flutter/material.dart';

import '../pages/orders_page.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Shop"), 
            automaticallyImplyLeading: false
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: Text("Shop", style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text("Orders", style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
          )
        ],
      ),
    );
  }

}