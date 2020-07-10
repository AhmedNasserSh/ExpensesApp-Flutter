import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavStatus() async {
    final oldSttatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = "https://shopapp-7e003.firebaseio.com/products/$id.json";
    final reponse = await http.patch(
      url,
      body: json.encode({
        'isFavourite': isFavourite,
      }),
    );
    print(reponse.body);
    if (reponse.statusCode != 200) {
      isFavourite = oldSttatus;
      notifyListeners();
    }
  }
}
