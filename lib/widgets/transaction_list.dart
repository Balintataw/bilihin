import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/widgets/transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return state.transactions.isEmpty 
        ? LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No transactions Today',
                  style: Theme.of(context).textTheme.headline6
                ),
                SizedBox(height: 15),
                Container(
                  height: constraints.maxHeight * 0.4,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ]
            );
          }
        )
        : ListView.builder(
          itemCount: state.transactions.length,
          itemBuilder: (BuildContext ctx, int index) {
            return TransactionListItem(tx: state.transactions[index]);
          },
        );
      }
    );
  }
}
