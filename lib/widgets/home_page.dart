import 'package:expenseTracker/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/widgets/chart.dart';
import 'package:expenseTracker/widgets/new_transaction.dart';
import 'package:expenseTracker/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  // final void Function() onInit;

  HomePage({this.store});
  // HomePage({this.store, this.onInit});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.onInit();
  // }

  void _showNewTransactionModal (context, store) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTransaction(store: store)),
    );
  }

  void _showSettingsModal (context, store) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings(store: store)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bilihin'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings
              ), 
              onPressed: () => _showSettingsModal(context, widget.store))
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
          onPressed: () => _showNewTransactionModal(context, widget.store),
        ),
        floatingActionButtonLocation: isLandscape ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}