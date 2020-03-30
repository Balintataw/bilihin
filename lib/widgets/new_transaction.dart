import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/redux/actions/transaction_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddNewTransaction;
  final Store<AppState> store;

  NewTransaction({this.onAddNewTransaction, this.store});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController(text: '0.0');
  DateTime _selectedDate;

  void _onSubmit() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if(title.isEmpty || amount <= 0 || _selectedDate == null) return;

  // void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: _selectedDate,
      id: DateTime.now().toString()
    );
    print(newTx);
    // widget.store.dispatch(AddTransactionAction(newTx));
    widget.store.dispatch(addTransaction(newTx));
    // setState(() {
    //   _transactions.add(newTx);
    // });
    // widget.onAddNewTransaction(title, amount, _selectedDate);

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year), 
      lastDate: DateTime.now()
    ).then((date) {
      if(date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Expense"),
      ),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.only(
            top: 8, 
            left: 8, 
            right: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                // onChanged: (value) => titleInput = value,
                controller: _titleController,
                onSubmitted: (_) => _onSubmit()
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) => amountInput = value,
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmit()
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null ? 
                        'No Date Chosen' :
                        'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      onPressed: _presentDatePicker, 
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _onSubmit,
                child: Text('Add'),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      )
    );
  }
    // return Card(
    //   // elevation: 5,
    //   child: Container(
    //     padding: EdgeInsets.all(8),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: <Widget>[
    //         TextField(
    //           decoration: InputDecoration(labelText: 'Name'),
    //           // onChanged: (value) => titleInput = value,
    //           controller: _titleController,
    //           onSubmitted: (_) => _onSubmit()
    //         ),
    //         TextField(
    //           decoration: InputDecoration(labelText: 'Amount'),
    //           // onChanged: (value) => amountInput = value,
    //           controller: _amountController,
    //           keyboardType: TextInputType.numberWithOptions(decimal: true),
    //           onSubmitted: (_) => _onSubmit()
    //         ),
    //         Container(
    //           height: 70,
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                 child: Text(_selectedDate == null ? 
    //                   'No Date Chosen' :
    //                   'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'
    //                 ),
    //               ),
    //               FlatButton(
    //                 textColor: Theme.of(context).primaryColorDark,
    //                 child: Text(
    //                   'Choose Date',
    //                   style: TextStyle(fontWeight: FontWeight.bold)
    //                 ),
    //                 onPressed: _presentDatePicker, 
    //               )
    //             ],
    //           ),
    //         ),
    //         RaisedButton(
    //           onPressed: _onSubmit,
    //           child: Text('Add'),
    //           color: Theme.of(context).primaryColor,
    //           textColor: Theme.of(context).textTheme.button.color,
    //         )
    //       ],
    //     ),
    //   )
    // );
  // }
}