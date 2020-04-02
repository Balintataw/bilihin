import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/bar_chart_data.dart';
import 'package:expenseTracker/selectors/selectors.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool showBaseline;
  final AppState state;

  SimpleBarChart(this.seriesList, {this.animate, this.showBaseline, this.state});

  /// Creates the 7 day chart.
  factory SimpleBarChart.withWeekData(AppState state) {
    return new SimpleBarChart(
      _createWeekData(state),
      animate: true,
      showBaseline: true,
      state: state,
    );
  }

  /// Creates the 30 day chart.
  factory SimpleBarChart.withMonthData(AppState state) {
    return new SimpleBarChart(
      _createMonthData(state),
      animate: true,
      showBaseline: false,
      state: state,
    );
  }


  @override
  Widget build(BuildContext context) {
    final lineColor = state.theme ? charts.MaterialPalette.white : charts.MaterialPalette.black;

    return new charts.BarChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
            // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 18, // size in Pts.
            color: lineColor
          ),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: lineColor
          )
        )
      ),
      domainAxis: new charts.OrdinalAxisSpec(
        // Make sure that we draw the domain axis line.
        showAxisLine: true,
        // But draw axis based on showBaseline flag.
        renderSpec: !showBaseline ? new charts.NoneRenderSpec() : new charts.SmallTickRendererSpec(
            // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 18,
            color: lineColor
          ),
          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: lineColor
          )
        ),
      ),
      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      // layoutConfig: new charts.LayoutConfig(
      //     leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     topMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
      //     bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),
    );
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
