import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ColorTypes {
  final Color color;
  final charts.MaterialPalette chartcolor;

  ColorTypes(this.color, this.chartcolor);
}

class BarChartData {
  final String day;
  final double amount;
  final String category;
  final dynamic color;

  BarChartData(this.day, this.amount, {this.category, this.color});

  static colorFromCategory(String category) {
    switch (category) {
      case 'food':
        {
          return charts.MaterialPalette.red.shadeDefault;
        }
      case 'clothing':
        {
          return charts.MaterialPalette.blue.shadeDefault;
        }
      case 'entertainment':
        {
          return charts.MaterialPalette.green.shadeDefault;
        }
      case 'utilities':
        {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        }

      default:
        {
          return charts.MaterialPalette.purple.shadeDefault;
        }
    }
  }
}