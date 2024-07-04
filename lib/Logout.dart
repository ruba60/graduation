import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'Views/login2.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    print('Widget loaded');
    Onload();
    // Code to be executed when the widget is loaded

  }
  Future<void> Logout() async{

  }
  @override
  Future<void> Onload() async {
    String myUrl = "http://127.0.0.1:8000/api/logout";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': token,
    });
    if(response.statusCode == 200){
      prefs.remove('token');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Log(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
