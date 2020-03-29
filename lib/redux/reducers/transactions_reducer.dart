import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final transactionsReducer = combineReducers<List<Transaction>>([
  TypedReducer<List<Transaction>, GetTransactionsAction>(_getTransactions),
  TypedReducer<List<Transaction>, GetRecentTransactionsAction>(_getRecentTransactions),
  TypedReducer<List<Transaction>, AddTransactionAction>(_addTransaction),
  TypedReducer<List<Transaction>, DeleteTransactionAction>(_deleteTransaction),
  TypedReducer<List<Transaction>, UpdateTransactionAction>(_updateTransaction),
  TypedReducer<List<Transaction>, TransactionsLoadedAction>(_setLoadedTransactions),
  TypedReducer<List<Transaction>, TransactionsNotLoadedAction>(_setNoTransactions),
]);

List<Transaction> _getTransactions(List<Transaction> transactions, GetTransactionsAction action) {
  return List.from(transactions);
}

List<Transaction> _getRecentTransactions(List<Transaction> transactions, GetRecentTransactionsAction action) {
  return transactions.where((tx) {
    return tx.date.isAfter(
      DateTime.now().subtract(
        Duration(days: 7)
      )
    );
  }).toList();
}

List<Transaction> _addTransaction(List<Transaction> transactions, AddTransactionAction action) {
  return List.from(transactions)..add(action.transaction);
}

List<Transaction> _deleteTransaction(List<Transaction> transactions, DeleteTransactionAction action) {
  return transactions.where((transactions) => transactions.id != action.id).toList();
}

List<Transaction> _updateTransaction(List<Transaction> transactions, UpdateTransactionAction action) {
  return transactions
      .map((transactions) => transactions.id == action.id ? action.updatedTransaction : transactions)
      .toList();
}

// List<Transaction> _clearCompleted(List<Transaction> transactionss, ClearCompletedAction action) {
//   return transactionss.where((transactions) => !transactions.complete).toList();
// }

// List<Transaction> _toggleAll(List<Transaction> transactionss, ToggleAllAction action) {
//   final allComplete = allCompleteSelector(transactionss);

//   return transactionss.map((transactions) => transactions.copyWith(complete: !allComplete)).toList();
// }

List<Transaction> _setLoadedTransactions(List<Transaction> transactions, TransactionsLoadedAction action) {
  return action.transactions;
}

List<Transaction> _setNoTransactions(List<Transaction> transactions, TransactionsNotLoadedAction action) {
  return [];
}