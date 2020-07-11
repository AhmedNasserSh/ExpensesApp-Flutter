import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  List<CartItem> products;
  final DateTime time;
  OrderItem({this.id, this.amount, this.products, this.time});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        "https://shopapp-7e003.firebaseio.com/orders/$userId.json?auth=$authToken";
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(data);
    if (data == null) {
      return;
    }
    final List<OrderItem> loadedOrders = [];
    data.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        time: DateTime.parse(orderData['dateTtime']),
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ))
            .toList(),
      ));
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> placeOrder(List<CartItem> products, double total) async {
    final url =
        "https://shopapp-7e003.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timeStamp = DateTime.now();
    final reponse = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTtime': timeStamp.toIso8601String(),
        'products': products
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'price': cp.price,
                  'quantity': cp.quantity,
                })
            .toList(),
      }),
    );
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(reponse.body)['name'],
          amount: total,
          time: timeStamp,
          products: products,
        ));
    notifyListeners();
  }
}
