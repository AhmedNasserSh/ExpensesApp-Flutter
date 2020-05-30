import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../models/transaction.dart';

class TrasactionItem extends StatefulWidget {
  const TrasactionItem({
    Key key,
    @required this.tx,
    @required Function deleteTX,
  })  : _deleteTX = deleteTX,
        super(key: key);

  final Transaction tx;
  final Function _deleteTX;

  @override
  _TrasactionItemState createState() => _TrasactionItemState();
}

class _TrasactionItemState extends State<TrasactionItem> {
  Color _bgColor; 

  @override
  void initState() {
    const avaialbleColors = [
      Colors.black,
      Colors.red,
      Colors.blue,
      Colors.purple
    ];

    _bgColor = avaialbleColors[Random().nextInt(3)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 50,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.tx.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMEd().format(widget.tx.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () => widget._deleteTX(widget.tx.id),
                icon: const Icon(Icons.delete),
                label: const Text(
                    'Delete'), // you don't have to rebuild this widget again when parent rebuilds
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget._deleteTX(widget.tx.id),
              ),
      ),
    );
  }
}
