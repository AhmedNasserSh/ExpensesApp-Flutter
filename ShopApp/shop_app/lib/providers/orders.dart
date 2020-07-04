import 'package:flutter/material.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  List<CartItem> products;
  final DateTime time;
  OrderItem({this.id, this.amount, this.products, this.time});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void placeOrder(List<CartItem> products, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          time: DateTime.now(),
          products: products,
        ));
    notifyListeners();
  }
}
