import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void popDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      controller: _titleController,
                      onChanged: (value) {
                        // titleInput = value;
                      },
                      onSubmitted: (_) => _submitData(),
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      controller: _amountController,
                      onSubmitted: (_) => _submitData(),
                      keyboardType: TextInputType.number,
                    )
                  : TextField(
                      controller: _amountController,
                      onChanged: (value) {
                        // amountInput = value;
                      },
                      decoration: InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Choosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: popDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : FlatButton(
                            onPressed: popDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            textColor: Theme.of(context).primaryColor,
                          )
                  ],
                ),
              ),
              RaisedButton(
                  child: Text(
                    'Add Transaction',
                  ),
                  onPressed: _submitData,
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
