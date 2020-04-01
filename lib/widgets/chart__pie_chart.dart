import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/selectors/selectors.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  factory SimplePieChart.withMonthData(AppState state) {
    return SimplePieChart(
      _createMonthData(state),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  static List<charts.Series<BarChartData, String>> _createMonthData(AppState state) {
    final data = transactionCategoriesByMonth(state);

    return [
      new charts.Series<BarChartData, String>(
        id: 'Category Month',
        colorFn: (BarChartData transaction, __) => transaction.color,
        // colorFn: (BarChartData transaction, __) => BarChartData.colorFromCategory(transaction.category),
        // colorFn: (BarChartData transaction, _) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (BarChartData transaction, _) => transaction.day,
        measureFn: (BarChartData transaction, _) => transaction.amount,
        data: data,
      )
    ];
  }
}