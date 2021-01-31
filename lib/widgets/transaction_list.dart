import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../models/const.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function trxToDelete;

  TransactionList({@required this.userTransaction, this.trxToDelete});

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: userTransaction.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   width: 80,
                      //   child: FittedBox( //this is to sort out the content size
                      //     child: Text(
                      //       '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18.0,
                      //         color: Theme.of(context).primaryColor,
                      //       ),
                      //     ),
                      //   ),
                      //   margin: EdgeInsets.symmetric(
                      //       vertical: 10.0, horizontal: 15),
                      //   decoration: BoxDecoration(
                      //     color: amountBackgroundColor,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //         color: Theme.of(context).primaryColor,
                      //         width: 2.0),
                      //   ),
                      //   padding: EdgeInsets.all(8),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: accentColor,
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            backgroundColor: amountBackgroundColor,
                            radius: 30,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, //this is default
                          children: [
                            Text(
                              userTransaction[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(userTransaction[index].date),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => trxToDelete(userTransaction[index].id),
                        color: Theme.of(context).errorColor,
                      ),
                    ],
                  ),
                );
              },
    );
  }
}

//TODO: Need to add a module to remember stuff,its called...