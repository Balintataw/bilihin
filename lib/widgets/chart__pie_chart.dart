import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/selectors/selectors.dart';
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  // factory SimplePieChart.withSampleData() {
  //   return new SimplePieChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }
  factory SimplePieChart.withMonthData(AppState state) {
    return SimplePieChart(
      _createMonthData(state),
      animate: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  static List<charts.Series<BarChartData, String>> _createMonthData(AppState state) {
    final data = transactionCategoriesByMonth(state);
    final red = charts.MaterialPalette.red.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);
    final blue = charts.MaterialPalette.blue.makeShades(2);

    return [
      new charts.Series<BarChartData, String>(
        id: 'Category Month',
        colorFn: (BarChartData transaction, __) {
          switch (transaction.color) {
            case "0":
              {
                return red[0];
              }
            case "1":
              {
                return blue[0];
              }
            case "2":
              {
                return green[0];
              }
            case "3":
              {
                return red[1];
              }
            case "4":
              {
                return blue[1];
              }
            case "5":
              {
                return green[1];
              }

            default:
              {
                return red[2];
              }
          }
        }, 
        // charts.MaterialPalette.green.shadeDefault,
        domainFn: (BarChartData transaction, _) => transaction.day,
        measureFn: (BarChartData transaction, _) => transaction.amount,
        data: data,
      )
    ];
  }
  /// Create one series with sample hard coded data.
  // static List<charts.Series<LinearSales, int>> _createSampleData() {
  //   final data = [
  //     new LinearSales(0, 100),
  //     new LinearSales(1, 75),
  //     new LinearSales(2, 25),
  //     new LinearSales(3, 5),
  //   ];

  //   return [
  //     new charts.Series<LinearSales, int>(
  //       id: 'Sales',
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}