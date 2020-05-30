import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function _deleteTX;

  TransactionList(this.transactions, this._deleteTX);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('No Transactions',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ]);
          })
        : ListView(
            children: transactions
                .map((tx) => TrasactionItem(
                    key: ValueKey(tx.id),
                      tx: tx,
                      deleteTX: _deleteTX,
                    ))
                .toList(),
          );
  }
}
