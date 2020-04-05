import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/category_type.dart';
import 'package:expenseTracker/widgets/chart__pie_chart.dart';
import 'package:expenseTracker/widgets/chart__bar_chart.dart';
import 'package:expenseTracker/selectors/selectors.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return LayoutBuilder(builder: (ctx, constraints) {
        final cardHeight = MediaQuery.of(context).orientation == Orientation.portrait ? constraints.maxHeight * 0.4 : constraints.maxHeight * 0.7;

          return SingleChildScrollView(
            child: Column(
              children: [ 
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const Text(
                    'Spending by Category',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: cardHeight,
                          child: SimplePieChart.withMonthData(state)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: CategoryType.getTypes().map((type) {
                            return Row(
                              children: <Widget>[
                                Text(type.name),
                                Text(
                                  '\u2022', 
                                  style: TextStyle(
                                    color: type.color,
                                    fontSize: 30
                                  )
                                ),
                              ],
                            );
                          }).toList()
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Last 7 days: \$${totalSpendingByPeriod(state, 7).toStringAsFixed(2)}', 
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: cardHeight,
                    padding: const EdgeInsets.all(10),
                    child: SimpleBarChart.withWeekData(state)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Last 30 days: \$${totalSpendingByPeriod(state, 30).toStringAsFixed(2)}', 
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: cardHeight,
                    padding: const EdgeInsets.all(10),
                    child: SimpleBarChart.withMonthData(state)
                  ),
                ),
                const SizedBox(height: 80)
              ],
            ),
          );
        });
    });
  }
}