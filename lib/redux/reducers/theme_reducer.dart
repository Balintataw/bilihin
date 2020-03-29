import 'package:expenseTracker/redux/actions/theme_actions.dart';
import 'package:redux/redux.dart';

final themeReducer = combineReducers<bool>([
  TypedReducer<bool, ToggleApplicationTheme>(_toggleTheme),
]);

bool _toggleTheme(bool state, action) {
  return !state;
}