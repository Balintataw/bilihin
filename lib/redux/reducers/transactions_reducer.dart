import 'package:redux/redux.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/redux/actions/transaction_actions.dart';

final transactionsReducer = combineReducers<List<Transaction>>([
  TypedReducer<List<Transaction>, SetTransactionsAction>(_setTransactions),
  TypedReducer<List<Transaction>, GetRecentTransactionsAction>(_getRecentTransactions),
  TypedReducer<List<Transaction>, AddTransactionAction>(_addTransaction),
  TypedReducer<List<Transaction>, DeleteTransactionAction>(_deleteTransaction),
  TypedReducer<List<Transaction>, UpdateTransactionAction>(_updateTransaction),
]);

List<Transaction> _setTransactions(List<Transaction> transactions, SetTransactionsAction action) {
  return List.from(action.transactions);
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
