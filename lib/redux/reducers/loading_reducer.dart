import 'package:redux/redux.dart';
import '../actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, TransactionsLoadedAction>(_setLoaded),
  TypedReducer<bool, TransactionsNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}