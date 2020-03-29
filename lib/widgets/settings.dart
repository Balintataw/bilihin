import 'package:expenseTracker/models/app_state.dart';
import 'package:expenseTracker/redux/actions/theme_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool currentTheme;
  final void Function(bool value) onToggleTheme;

  _ViewModel(this.onToggleTheme, this.currentTheme);
}

class Settings extends StatefulWidget {
  final Store<AppState> store;

  Settings({this.store});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
          converter: (store) {
              final currentTheme = store.state.theme;
            return _ViewModel(
              (value) => store.dispatch(ToggleApplicationTheme(value: value)),
              currentTheme,
            );
          }, 
          builder: (context, viewModel) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Switch.adaptive(
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (val) => viewModel.onToggleTheme(val), 
                        value: viewModel.currentTheme
                      )
                    ]
                  )
                ],
              )
            );
          }
        )
    );
  }
}