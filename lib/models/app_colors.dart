import 'package:flutter/material.dart';

class AppColors {
  AppColors(this.color, this.name);
  final Color color;
  final String name;

  static Color find(String color) {
          switch (color) {
            case "red":
              {
                return Colors.red;
              }
            case "blue":
              {
                return Colors.blue;
              }
            case "green":
              {
                return Colors.green;
              }
            case "purple":
              {
                return Colors.purple;
              }
            case "grey":
              {
                return Colors.grey;
              }
            case "orange":
              {
                return Colors.orange;
              }

            default:
              {
                return Colors.black;
              }
          }
  //    AppColors(null, 'Clear'),
  //    AppColors(Colors.orange, 'Orange'),
  //    AppColors(Colors.red, 'Red'),
  //    AppColors(Colors.green, 'Green'),
  //    AppColors(Colors.purple, 'Purple'),
  //    AppColors(Colors.grey, 'Grey'),
  // ];
  }
}