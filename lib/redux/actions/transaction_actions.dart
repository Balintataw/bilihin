import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';

const String _TRANSACTIONS = 'transactions';

ThunkAction<AppState> loadTransactions = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedTransactions = prefs.getString(_TRANSACTIONS);

  final jsonResponse = json.decode(storedTransactions) as List;
  final List<Transaction> transactions = jsonResponse != null 
    ? jsonResponse.map((i) => Transaction.fromJson(i)).toList() 
    : [];

  store.dispatch(SetTransactionsAction(transactions));
};

ThunkAction<AppState> addTransaction(Transaction transaction) {
  return (Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final existingTransactions = store.state.transactions;

    existingTransactions.add(transaction);
    final encoded = jsonEncode(existingTransactions);

    prefs.setString(_TRANSACTIONS, encoded);
    store.dispatch(SetTransactionsAction(existingTransactions));
  };
}

ThunkAction<AppState> deleteTransaction(String id) {
  return (Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final existingTransactions = store.state.transactions;

    existingTransactions.removeWhere((tx) => tx.id == id);
    final encoded = jsonEncode(existingTransactions);

    prefs.setString(_TRANSACTIONS, encoded);
    store.dispatch(DeleteTransactionAction(id));
  };
}

class SetTransactionsAction {
  final List<Transaction> transactions;

  SetTransactionsAction(this.transactions);

  @override
  String toString() {
    return 'SetTransactionsAction{transactions: $transactions}';
  }
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
  Transaction transaction;

  AddTransactionAction(this.transaction);

// factory AddTransactionAction.add(Transaction transaction) {


// }

  @override
  String toString() {
    return 'AddTransactionAction{transaction: $transaction}';
  }
}