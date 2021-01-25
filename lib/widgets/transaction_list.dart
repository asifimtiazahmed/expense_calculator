
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../models/const.dart';


class TransactionList extends StatelessWidget {

  final List<Transaction> userTransaction;

  TransactionList({@required this.userTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 300,
      child: ListView.builder(
        itemCount: userTransaction.length,
        itemBuilder: (ctx, index){
        return Card(
          elevation: 3,
          child: Row(
            children: [
              Container(
                width: 100,
                child: Text(
                  '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                margin:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
                ),
                padding: EdgeInsets.all(8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, //this is default
                children: [
                  Text(
                    userTransaction[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat.yMMMd().format(userTransaction[index].date),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      ),
    );
  }
}
