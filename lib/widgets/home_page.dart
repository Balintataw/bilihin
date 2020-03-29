import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/widgets/chart.dart';
import 'package:expenseTracker/widgets/new_transaction.dart';
import 'package:expenseTracker/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  final void Function() onInit;

  HomePage({this.store, this.onInit});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  void _showModal (context, store) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTransaction(store: store)),
    );
  }

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Bilihin'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.settings), onPressed: () {})
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.insert_chart)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TransactionList(),
              Chart(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _showModal(context, widget.store),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
    );
  }
}