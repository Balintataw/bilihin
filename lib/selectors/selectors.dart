import 'package:collection/collection.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/models/category_type.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:intl/intl.dart';

List<Transaction> recentTransactions(AppState state, int dayCount) {
    return state.transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: dayCount)
        )
      );
    }).toList();
}

List<BarChartData> transactionValuesByWeek(AppState state) {
  return List<BarChartData>.generate(7, (int index) {
    final weekDay = DateTime.now().subtract(Duration(days: index));
    var totalDayExpenditure = 0.0;
    var recent = recentTransactions(state, 7);

    for (var i = 0; i < recent.length; i++) {
      if(
        recent[i].date.day == weekDay.day &&
        recent[i].date.month == weekDay.month &&
        recent[i].date.year == weekDay.year
      ) {
        totalDayExpenditure += recent[i].amount;
      } 
    }

    return BarChartData(
      DateFormat.E().format(weekDay).substring(0, 2),
      totalDayExpenditure
    );
  }).reversed.toList();
}

List<BarChartData> transactionValuesByMonth(AppState state) {
  return List<BarChartData>.generate(30, (int index) {
    final weekDay = DateTime.now().subtract(Duration(days: index));
    var totalDayExpenditure = 0.0;
    var recent = recentTransactions(state, 30);

    for (var i = 0; i < recent.length; i++) {
      if(
        recent[i].date.day == weekDay.day &&
        recent[i].date.month == weekDay.month &&
        recent[i].date.year == weekDay.year
      ) {
        totalDayExpenditure += recent[i].amount;
      } 
    }

    return BarChartData(
      DateFormat.d().format(weekDay),
      totalDayExpenditure
    );
  }).reversed.toList();
}

List<BarChartData> transactionCategoriesByMonth(AppState state) {
  var recent = recentTransactions(state, 30);
  var _categories = CategoryType.getTypes();
  List<BarChartData> result = [];

  for (var i = 0; i < _categories.length; i++) {
    var totalCategoryExpenditure = 0.0;
    for (var j = 0; j < recent.length; j++) {
      if(
        recent[j].category == _categories[i].name
      ) {
        totalCategoryExpenditure += recent[j].amount;
      } 
    }
    result.add(BarChartData(
      _categories[i].name,
      totalCategoryExpenditure,
      color: BarChartData.colorFromCategory(_categories[i].name)
    ));
  }
  return result;
}

double totalSpendingByPeriod(AppState state, int days) {
  return recentTransactions(state, days).fold(0.0, (previousValue, tx) {
    return previousValue += tx.amount;
  });
}

List<Map<String, Object>> groupedByDateTransactionValues(AppState state) {
    List<Transaction> txs = state.transactions;
    txs.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return -aDate.compareTo(bDate);
    }); 
    var newMap = groupBy(
      txs,
      (Transaction obj) => DateFormat.yMMMd().format(obj.date)
    );
    List<Map<String, Object>> result = newMap.keys.map((key) { 
      return {
        key: newMap[key]
      };
    }).toList();
    // .sort((a, b) => a.keys.elementAt(0).compareTo(b.keys.elementAt(0)));
    return result;
}

List<Map<String, Object>> groupedByCategoryTransactionValues(AppState state) {
    var newMap = groupBy(
      state.transactions, 
      (Transaction obj) => obj.category
    );
    List<Map<String, Object>> result = newMap.keys.map((key) { 
      return {
        key: newMap[key]
      };
    }).toList();
    // .sort((a, b) => a.keys.elementAt(0).compareTo(b.keys.elementAt(0)));
    return result;
}