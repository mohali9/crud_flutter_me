import 'package:crud_flutter_me/api/api_service.dart';
import 'package:crud_flutter_me/home/create.dart';
import 'package:crud_flutter_me/home/homescreen.dart';
import 'package:crud_flutter_me/login/login.dart';
import 'package:crud_flutter_me/login/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/homescreen': (BuildContext context) => new HomeScreen(),
        '/login': (BuildContext context) => new Login(),
        '/create': (BuildContext context) => new FormAddScreen(),
      },
    );
  }
}
