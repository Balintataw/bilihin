import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';

class TransactionListGroup extends StatelessWidget {
  final List<Transaction> transactionGroup;
  final Key key;

  TransactionListGroup({@required this.key, @required this.transactionGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: transactionGroup.length,
      itemBuilder: (BuildContext ctx, int index) {
        return TransactionListItem(key: ValueKey(index.toString() + 'list_item'), tx: transactionGroup[index]);
      }
    );
  }
}