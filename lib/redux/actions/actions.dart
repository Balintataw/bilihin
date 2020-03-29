import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';

class LoadTransactionsAction {}

class TransactionsNotLoadedAction {}

ThunkAction<AppState> getTransactions = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedTransactions = prefs.getString('transactions');
  final transactions = storedTransactions != null ? json.decode(storedTransactions) : null;
  store.dispatch(GetTransactionsAction());
};

class GetTransactionsAction {

  GetTransactionsAction();
}

class GetRecentTransactionsAction {

  GetRecentTransactionsAction();
}

class TransactionsLoadedAction {
  final List<Transaction> transactions;

  TransactionsLoadedAction(this.transactions);

  @override
  String toString() {
    return 'TransactionsLoadedAction{transactions: $transactions}';
  }
}

class UpdateTransactionAction {
  final String id;
  final Transaction updatedTransaction;

  UpdateTransactionAction(this.id, this.updatedTransaction);

  @override
  String toString() {
    return 'UpdateTransactionAction{id: $id, updatedTransaction: $updatedTransaction}';
  }
}

class DeleteTransactionAction {
  final String id;

  DeleteTransactionAction(this.id);
  @override
  String toString() {
    return 'DeleteTransactionAction{id: $id}';
  }
}

class AddTransactionAction {
  final Transaction transaction;

  AddTransactionAction(this.transaction);

  @override
  String toString() {
    return 'AddTransactionAction{transaction: $transaction}';
  }
}