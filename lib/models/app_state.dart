import 'package:expenseTracker/models/transaction.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Transaction> transactions;
  final bool theme;

  AppState({
    this.theme,
    this.isLoading,
    this.transactions,
  });

  factory AppState.initial() {
    return AppState(isLoading: true, theme: false, transactions: [
      Transaction(
          id: '1', title: 'New Koshka', amount: 99.99, date: DateTime.now()),
      Transaction(
          id: '2', title: 'New Tuta', amount: 16.99, date: DateTime.now()),
    ]);
  }

  AppState copyWith({
    String theme,
    bool isLoading,
    List<Transaction> transactions,
  }) {
    return AppState(
      theme: theme ?? this.theme,
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  int get hashCode =>
    theme.hashCode ^
    isLoading.hashCode ^
    transactions.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          isLoading == other.isLoading &&
          transactions == other.transactions;

  @override
  String toString() {
    return 'AppState{theme: $theme, isLoading: $isLoading, transactions: $transactions}';
  }
}