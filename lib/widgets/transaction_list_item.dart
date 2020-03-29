import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/redux/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class _ViewModel {
  final Transaction transaction;
  final void Function(String id) onItemSelected;

  _ViewModel(this.transaction, this.onItemSelected);
}

class TransactionListItem extends StatelessWidget {
  final Transaction tx;

  TransactionListItem({this.tx});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
              '\$${tx.amount.toStringAsFixed(2)}'
              ),
            ),
          )
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(tx.date),
          style: TextStyle(
            color: Colors.grey
          )
        ),
        trailing: StoreConnector<AppState, _ViewModel>(
          converter: (store) {
            final transaction = tx;
            return _ViewModel(
              transaction,
              (id) => store.dispatch(DeleteTransactionAction(id))
            );
          }, 
          builder: (context, viewModel) {
            return mediaQuery.size.width > 380 
              ? FlatButton.icon(
                onPressed: () {
                  viewModel.onItemSelected(tx.id);
                },
                icon: Icon(Icons.delete), 
                textColor: Theme.of(context).errorColor,
                label: Text('Delete')
              ) 
              : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ), 
                onPressed: () {
                  viewModel.onItemSelected(tx.id);
                }
              );
          }
        ),
      ),
    );
  }
}