import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/redux/reducers/loading_reducer.dart';
import 'package:expenseTracker/redux/reducers/theme_reducer.dart';
import 'package:expenseTracker/redux/reducers/transactions_reducer.dart';
// We create the State reducer by combining many smaller reducers into one!

AppState appReducer(AppState state, action) {
  return AppState(
    theme: themeReducer(state.theme, action),
    isLoading: loadingReducer(state.isLoading, action),
    transactions: transactionsReducer(state.transactions, action),
  );
}