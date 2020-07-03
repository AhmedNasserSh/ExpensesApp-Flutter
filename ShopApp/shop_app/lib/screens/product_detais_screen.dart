import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import '../providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  Product getProduct(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    return Provider.of<Products>(
      context,
      listen: false,
    ).findById(id); // don't listen for changes
  }

  @override
  Widget build(BuildContext context) {
    final product = getProduct(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
