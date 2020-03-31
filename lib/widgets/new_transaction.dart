import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/category_type.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/redux/actions/transaction_actions.dart';
import 'package:expenseTracker/widgets/category_dropdown.dart';
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
  CategoryType _selectedExpenseType;
  
  @override
  initState() {
    // _selectedExpenseType = 
    // _selectedExpenseType = _dropdownMenuItems[0].value;
  }

  onChangeDropdownItem(CategoryType selectedType) {
    print('S ${selectedType.name}');
    setState(() {
      _selectedExpenseType = selectedType;
    });
  }

  void _onSubmit() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if(title.isEmpty || amount <= 0 || _selectedDate == null) return;

    print(_selectedExpenseType.name);
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: _selectedDate,
      id: DateTime.now().toString(),
      category: _selectedExpenseType.name
    );

    widget.store.dispatch(addTransaction(newTx));

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
                controller: _titleController,
                onSubmitted: (_) => _onSubmit()
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmit()
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CategoryDropdown(
                  onSelect: onChangeDropdownItem,
                  selectedItem: _selectedExpenseType
                )
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
}