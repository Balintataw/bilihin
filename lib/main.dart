import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import './redux/reducers/app_state_reducer.dart';
import './models/app_state.dart';
import './widgets/home_page.dart';

void main() {
  final store = Store<AppState>(
    appReducer, 
    initialState: AppState.initial(), 
    middleware: [thunkMiddleware]
  );
  runApp(
    StoreProvider<AppState>(
      store: store, 
      child: App()
    )
  );
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp, 
  //   DeviceOrientation.portraitDown
  // ]);
}

class App extends StatelessWidget {
  // final Store<AppState> store;

  // App({this.store});

  // _onInit(context) {
  //   var t = store.state.transactions;
  //   print(t.toString());
  //   return t;
  // }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bilihin',
          home: HomePage(store: store),
          // home: HomePage(store: store, onInit: () => _onInit(context)),
          theme: 
          ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.redAccent,
            brightness: store.state.theme ? Brightness.dark : Brightness.light,
            fontFamily: 'Quicksand',
            textTheme: TextTheme().apply(fontFamily: 'OpenSans'),
            // ThemeData. .textTheme.copyWith(
            //   headline6: TextStyle(
            //     fontFamily: 'OpenSans',
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16
            //   ),
            //   button: TextStyle(color: Colors.white)
            // ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )
              )
            )
          ),
        );
      }
    );
  }
}