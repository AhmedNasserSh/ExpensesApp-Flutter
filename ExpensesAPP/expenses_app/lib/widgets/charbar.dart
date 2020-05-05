import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double prcentage;
  ChartBar(this.label, this.amount, this.prcentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, consttrains) {
        return Column(children: <Widget>[
          Container(
            height: consttrains.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\$${amount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(height: consttrains.maxHeight * 0.05),
          Container(
            height: consttrains.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10))),
                FractionallySizedBox(
                  heightFactor: prcentage,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
          ),
          SizedBox(height: consttrains.maxHeight * 0.05),
          Container(
            height: consttrains.maxHeight * 0.15,
            child: FittedBox(
              child: Text('$label'),
            ),
          ),
        ]);
      },
    );
  }
}
