import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';

class TransactionListGroup extends StatelessWidget {
  final List<Transaction> transactionGroup;

  TransactionListGroup({this.transactionGroup});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: transactionGroup.length,
      itemBuilder: (BuildContext ctx, int index) {
        return TransactionListItem(tx: transactionGroup[index]);
      }
    );
  }
}