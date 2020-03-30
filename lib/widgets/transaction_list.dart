import 'package:expenseTracker/selectors/selectors.dart';
import 'package:expenseTracker/widgets/transaction_list_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:sticky_headers/sticky_headers.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        final list = groupedByDateTransactionValues(state);
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
          shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext ctx, int index) {
              return StickyHeader(
                overlapHeaders: false,
                header: Container(
                  height: 30.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(list[index].keys.elementAt(0)), 
                ),
                content: Container(
                  child: TransactionListGroup(transactionGroup: list[index].values.elementAt(0))
                )
              );
            }
          );
      }
    );
  }
}
