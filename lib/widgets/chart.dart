import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/selectors/selectors.dart';
import 'package:expenseTracker/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [ 
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Last 7 days: \$${totalWeekSpending(state).toStringAsFixed(2)}', 
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.all(8),
                child: Container(
                  height: constraints.maxHeight * 0.4,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupedTransactionValues(state).map((tx) {
                      return Flexible(
                        fit: FlexFit.loose,
                        child: ChartBar(
                          label: tx['day'], 
                          spendingAmount: tx['amount'], 
                          spendingPercentage: totalWeekSpending(state) == 0.0 ? 0.0 : (tx['amount'] as double) / totalWeekSpending(state)
                        )
                      );
                    }).toList()
                  ),
                ),
              ),
            ],
          );
        });
    });
  }
}