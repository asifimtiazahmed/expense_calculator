import 'package:flutter/material.dart';
import 'package:flutter_expense_calc/widgets/new_transaction.dart';
import 'package:flutter_expense_calc/widgets/transaction_list.dart';
import 'package:flutter/services.dart';
import 'dart:io'; // we use this to check platform

import 'models/const.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

//edit
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: themeColor,
        //accentColor: accentColor,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          color: themeColor,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  // bool isLandscape = SystemChrome.setPreferredOrientations(orientations)

  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateData) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: dateData,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String idToDelete) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == idToDelete);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            }),
      ],
    );
    var chartWidget = Container(
      height:
          (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
              ((isLandscape) ? 0.50 : 0.30),
      child: Chart(
        recentTransactions: _recentTransactions,
      ),
    );
    var trxList = Container(
      height:
          (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
              0.65,
      child: TransactionList(
        userTransaction: _userTransaction,
        trxToDelete: _deleteTransaction,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                    child: Text('show chart'),
                  ),
                  Switch.adaptive( //we use adaptive to change it with iOS
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: ((val) {
                      setState(() {
                        _showChart = val;
                        print(val);
                      });
                    }),
                  ),
                ],
              ),
             if(isLandscape) (_showChart ? chartWidget : trxList),
              //UserTransactions()}
              if(!isLandscape) chartWidget,
              if(!isLandscape) trxList,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: amountBackgroundColor,
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
