
import 'package:flutter/material.dart';

import '../models/const.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrx;

  NewTransaction(this.addTrx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0){
      print('entry rejected');
      return;
    }

    widget.addTrx(titleController.text,
        double.tryParse(amountController.text)); //Positional arguments don't work here
    titleController.clear();
    amountController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
        child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              cursorColor: themeColor,
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (titleValue){
              //   titleInput = titleValue;
              // },
              controller: titleController,
            ),
            TextField(
              cursorColor: themeColor,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
              // onChanged: (val)=> amountInput = val,
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color:
                  themeTextColor, //ToDO: Put a way for conditional argument so if theme color then white otherwihse dark
                ),
              ),
              color: themeColor,
            )
          ],
        ),
      ),
    );
  }
}
