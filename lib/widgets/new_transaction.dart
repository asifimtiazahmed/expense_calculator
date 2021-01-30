import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/const.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrx;

  NewTransaction(this.addTrx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.isEmpty){
      return;
    }
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      print('entry rejected');
      return;
    }

    widget.addTrx(
        _titleController.text,
        double.tryParse(_amountController.text),
      _selectedDate,
    ); //Positional arguments don't work here
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now()).then(
        (pickedDate){
          if(pickedDate == null){
            return;
          }
          setState(() {
            _selectedDate = pickedDate;
          });
        }
    );
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
              controller: _titleController,
            ),
            TextField(
              cursorColor: themeColor,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //onSubmitted: (_) => _submitData(), //Disabled so that date picker can be chosen
              // onChanged: (val)=> amountInput = val,
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: Text((_selectedDate == null) ? 'No Date Chosen' : 'Transaction Date: ${DateFormat.yMd().format(_selectedDate)}')),
                  FlatButton(
                    child: Text(
                      'choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
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
