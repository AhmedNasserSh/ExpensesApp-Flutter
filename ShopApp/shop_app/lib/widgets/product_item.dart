import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/product_detais_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({this.id, this.title, this.imageUrl});

  void _addCartTime(Cart cart, Product product, BuildContext context) {
    cart.addItem(
      product.id,
      product.title,
      product.price,
    );
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'item added to cart',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () => cart.removeSnigleCartItem(product.id)),
      ),
    ); // of context means nears scaffold whiich is products overview
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            //use consumer to  listen on changes of product on this widget only so it rebuilds here only
            builder: (ctx, product, _) => IconButton(
              icon: product.isFavourite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () => product.toggleFavStatus(auth.token, auth.userId),
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => _addCartTime(cart, product, context),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
