import 'package:expenseTracker/models/app_colors.dart';
import 'package:expenseTracker/models/category_type.dart';
import 'package:expenseTracker/widgets/chart__pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/selectors/selectors.dart';
import 'package:expenseTracker/widgets/chart__bar_chart.dart';

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
                  child: Text(
                    'Spending by Category',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: cardHeight,
                        padding: EdgeInsets.all(10),
                        child: SimplePieChart.withMonthData(state)
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: CategoryType.getTypes().map((e) {
                              return Row(
                                children: <Widget>[
                                  Text(e.name),
                                  Text(
                                    '\u2022', 
                                    style: TextStyle(
                                      color: AppColors.find(e.color),
                                      fontSize: 30
                                    )
                                  ),
                                ],
                              );
                            }).toList()
                        )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Last 7 days: \$${totalSpendingByPeriod(state, 7).toStringAsFixed(2)}', 
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: cardHeight,
                    padding: EdgeInsets.all(10),
                    child: SimpleBarChart.withWeekData(state)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Last 30 days: \$${totalSpendingByPeriod(state, 30).toStringAsFixed(2)}', 
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: cardHeight,
                    padding: EdgeInsets.all(10),
                    child: SimpleBarChart.withMonthData(state)
                  ),
                ),
                SizedBox(height: 80)
              ],
            ),
          );
        });
    });
  }
}