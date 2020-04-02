import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:expenseTracker/models/app_state.dart';

const String _THEME = 'bilihin/theme';

ThunkAction<AppState> toggleTheme = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final bool storedTheme = store.state.theme;

  prefs.setBool(_THEME, !storedTheme);
  store.dispatch(ToggleThemeAction(!storedTheme));
};


class ToggleThemeAction {
  final bool theme;

  ToggleThemeAction(this.theme);

  @override
  String toString() {
    return 'ToggleThemeAction{theme: $theme}';
  }
}