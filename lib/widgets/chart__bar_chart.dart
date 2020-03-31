import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/selectors/selectors.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool showBaseline;

  SimpleBarChart(this.seriesList, {this.animate, this.showBaseline});

  /// Creates the 7 day chart.
  factory SimpleBarChart.withWeekData(AppState state) {
    return new SimpleBarChart(
      _createWeekData(state),
      animate: true,
      showBaseline: true,
    );
  }

  /// Creates the 30 day chart.
  factory SimpleBarChart.withMonthData(AppState state) {
    return new SimpleBarChart(
      _createMonthData(state),
      animate: true,
      showBaseline: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      /// Assign a custom style for the measure axis.
      ///
      /// The NoneRenderSpec can still draw an axis line with
      /// showAxisLine=true.
      // primaryMeasureAxis:
      //     new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),

      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
        // Make sure that we draw the domain axis line.
        showAxisLine: true,
        // But don't draw anything else.
        renderSpec: !showBaseline ? new charts.NoneRenderSpec() : null
      ),
      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      // layoutConfig: new charts.LayoutConfig(
      //     leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     topMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),
    );
    // );
  }

  static List<charts.Series<BarChartData, String>> _createWeekData(AppState state) {
    final data = transactionValuesByWeek(state);

    return [
      new charts.Series<BarChartData, String>(
        id: 'Week',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (BarChartData transaction, _) => transaction.day,
        measureFn: (BarChartData transaction, _) => transaction.amount,
        data: data,
      )
    ];
  }

  static List<charts.Series<BarChartData, String>> _createMonthData(AppState state) {
    final data = transactionValuesByMonth(state);

    return [
      new charts.Series<BarChartData, String>(
        id: 'Month',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (BarChartData transaction, _) => transaction.day,
        measureFn: (BarChartData transaction, _) => transaction.amount,
        data: data,
      )
    ];
  }
}
