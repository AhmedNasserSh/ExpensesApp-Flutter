import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.error != null) {
            return Center(
              child: Text('Could Not Fetch Orders'),
            );
          }
          return Consumer<Orders>(
            builder: (context, orders, _) => ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
            ),
          );
        },
      ),
    );
  }
}
