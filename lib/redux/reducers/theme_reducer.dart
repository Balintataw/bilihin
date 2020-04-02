import 'package:expenseTracker/redux/actions/theme_actions.dart';
import 'package:redux/redux.dart';

final themeReducer = combineReducers<bool>([
  TypedReducer<bool, ToggleThemeAction>(_setTheme),
]);

bool _setTheme(bool state, action) {
  return action.theme;
}