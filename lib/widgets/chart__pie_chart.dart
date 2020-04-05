import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/selectors/selectors.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool isEmpty;

  SimplePieChart(this.seriesList, {this.animate, this.isEmpty});

  factory SimplePieChart.withMonthData(AppState state) {
    return SimplePieChart(
      _createMonthData(state),
      animate: true,
      isEmpty: _isEmpty(state)
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isEmpty) {
      return Center(child: Container(child: Text('No expenses yet'),));
    } else {
      return charts.PieChart(seriesList, animate: animate);
    }
  }

  static bool _isEmpty(AppState state) {
    final data = transactionCategoriesByMonth(state);
    double total = data.fold(0, (previousValue, element) {
      return previousValue += element.amount;
    });
    if(total <= 0.0) {
      return true;
    }
    return false;
  }

  static List<charts.Series<BarChartData, String>> _createMonthData(AppState state) {
    final data = transactionCategoriesByMonth(state);

    return [
      new charts.Series<BarChartData, String>(
        id: 'Category Month',
        colorFn: (BarChartData transaction, __) => transaction.color,
        domainFn: (BarChartData transaction, _) => transaction.day,
        measureFn: (BarChartData transaction, _) => transaction.amount,
        data: data,
      )
    ];
  }
}