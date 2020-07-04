import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, index) => Column(
                  children: <Widget>[
                    UserProductItem(
                      id: products.items[index].id,
                      title: products.items[index].title,
                      imageUrl: products.items[index].imageUrl,
                      deleteProduct: () =>
                          products.deleteProduct(products.items[index].id),
                    ),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
