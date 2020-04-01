import 'package:flutter/material.dart';

class CategoryType {
  String name;
  Color color;

  CategoryType(this.name, this.color);

  static List<CategoryType> getTypes() {
    return <CategoryType>[
      CategoryType('food', Colors.red),
      CategoryType('clothing', Colors.blue),
      CategoryType('entertainment', Colors.green),
      CategoryType('utilities', Colors.deepOrange),
      CategoryType('other', Colors.purple),
    ];
  }
}