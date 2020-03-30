import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id, 
    @required this.title, 
    @required this.amount, 
    @required this.date
  });

  Map toJson() => {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toString()
    };
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      date: DateTime.parse(json["date"]),
  );
}