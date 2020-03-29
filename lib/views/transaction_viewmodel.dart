import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:redux/redux.dart';

class TransactionViewModel {
  final bool isLoading;
  // final bool loginError;
  final List<Transaction> transactions;

  TransactionViewModel({
    this.isLoading,
    // this.loginError,
    this.transactions,
  });

  static TransactionViewModel fromStore(Store<AppState> store) {
    return TransactionViewModel(
      isLoading: store.state.isLoading,
      transactions: store.state.transactions
      // loginError: store.state.userState.loginError,
      // user: store.state.userState.user,
      // login: (String username, String password) {
      //   store.dispatch(loginUser(username, password));
      // },
    );
  }
}