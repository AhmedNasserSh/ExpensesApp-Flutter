import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))
          ],
        ),
      ),
    );
  }
}
