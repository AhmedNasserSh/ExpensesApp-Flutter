import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_Exceptions.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  var showFavOnly = false;

  List<Product> get items {
    // if (showFavOnly) {
    //   return _items.where((element) => element.isFavourite).toList();
    // }
    return [..._items]; // return copy of _items
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  // void setshowFavOnly() {
  //   showFavOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showFavOnly = false;
  //   notifyListeners();
  // }
  Future<void> fetchProducts() {
    const url = "https://shopapp-7e003.firebaseio.com/products.json";
    return http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      if (data == null) {
        return;
      }
      final List<Product> products = [];
      data.forEach((key, prodData) {
        products.add(Product(
          id: key,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite: prodData['isFavourite'],
        ));
      });
      _items = products;
      notifyListeners();
    }).catchError((error) {});
  }

  Future<void> addProduct(Product product) async {
    const url = "https://shopapp-7e003.firebaseio.com/products.json";
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavourite': false,
          },
        ),
      );
      final body = json.decode(response.body);
      print(body);
      product.id = body['name'];
      _items.insert(0, product);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      final url =
          "https://shopapp-7e003.firebaseio.com/products/${product.id}.json";
      await http.patch(
        url,
        body: json.encode(
          {
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    } else {
      return addProduct(product);
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = "https://shopapp-7e003.firebaseio.com/products/$id.json";
    final response = await http.delete(url);
    if (response.statusCode >= 200) {
      throw HTTPException('Couuld not delete product');
    }
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
