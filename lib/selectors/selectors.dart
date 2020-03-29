import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:intl/intl.dart';

List<Transaction> recentTransactions(AppState state) {
    return state.transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
}

List<Map<String, Object>> groupedTransactionValues(AppState state) {
  return List.generate(7, (int index) {
    final weekDay = DateTime.now().subtract(Duration(days: index));
    var totalDayExpenditure = 0.0;
    var recent = recentTransactions(state);

    for (var i = 0; i < recent.length; i++) {
      if(
        recent[i].date.day == weekDay.day &&
        recent[i].date.month == weekDay.month &&
        recent[i].date.year == weekDay.year
      ) {
        totalDayExpenditure += recent[i].amount;
      } 
    }

    return {
      'day': DateFormat.E().format(weekDay).substring(0, 1),
      'amount': totalDayExpenditure
    };
  }).reversed.toList();
}

double totalWeekSpending(AppState state) {
  return groupedTransactionValues(state).fold(0.0, (previousValue, tx) {
    return previousValue += tx['amount'];
  });
}