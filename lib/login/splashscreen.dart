import 'dart:async';
import 'package:flutter/material.dart';
import 'localStorage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // varibel
  String _status;

  Future<Null> getSharedPrefs() async {
    DataStore dataStore = new DataStore();
    _status = await dataStore.getDataString("sudah_login");
    print(_status);
    if (_status == "Tidak ditemukan") {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/login"));
    } else if (_status == "sudah") {
      Timer(Duration(seconds: 2),
          () => Navigator.pushNamed(context, "/homescreen"));
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.orange[200],
              Colors.teal[300],
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: new Center(
            child: new Image.asset(
              'img/splash.png',
              width: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}
