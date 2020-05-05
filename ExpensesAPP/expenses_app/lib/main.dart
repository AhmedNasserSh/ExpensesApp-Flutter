import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.green,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transations = [
    Transaction(
        amount: 10,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        title: 'TX1'),
    Transaction(
        amount: 10,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        title: 'TX1'),
    Transaction(
        amount: 10,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        title: 'TX1'),
    Transaction(
        amount: 10,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        title: 'TX1'),
  ];
  List<Transaction> get _recentTransaction {
    return _transations.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _transations.add(newTx);
    });
  }

  void _showNewTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _transations.removeWhere((tx) => tx.id == id);
    });
  }

  void _showChartSwitch(bool val) {
    setState(() => _showChart = val);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? buildCupertinoNavigationBar(context)
        : buildAppBar(context);
    final transList = buildTransList(mediaQuery, appBar);
    final pageBody = buildSingleChildScrollView(
        isLandScape, context, mediaQuery, appBar, transList);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _showNewTransactionSheet(context),
                    child: Icon(Icons.add)),
          );
  }

  SafeArea buildSingleChildScrollView(
      bool isLandScape,
      BuildContext context,
      MediaQueryData mediaQuery,
      PreferredSizeWidget appBar,
      Container transList) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape) buildSwitch(context),
            if (!isLandScape) buildChart(mediaQuery, appBar, 0.3),
            if (!isLandScape) transList,
            if (isLandScape)
              _showChart ? buildChart(mediaQuery, appBar, 0.7) : transList,
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNewTransactionSheet(context))
      ],
    );
  }

  CupertinoNavigationBar buildCupertinoNavigationBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _showNewTransactionSheet(context),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  Row buildSwitch(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Show Chart',
        style: Theme.of(context).textTheme.title,
      ),
      Switch.adaptive(
        activeColor: Theme.of(context).accentColor,
        value: _showChart,
        onChanged: _showChartSwitch,
      ),
    ]);
  }

  Container buildTransList(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transations, _deleteTransactions),
    );
  }

  Container buildChart(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    double multiple,
  ) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          multiple,
      child: Chart(_recentTransaction),
    );
  }
}
