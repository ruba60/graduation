import 'package:flutter/material.dart';
import 'package:graduation_project/Views/Store_Keeper/storekeeper.dart';
import 'package:graduation_project/Views/Test_Lab/testlab.dart';
import 'package:graduation_project/Views/Test_Lab/testlab_Amb.dart';
import 'package:graduation_project/Views/X_Ray/x_ray_.dart';
import 'package:graduation_project/Views/X_Ray/x_ray_Amb.dart';

import 'Views/login2.dart';
import 'login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StoreKeeper(),

    );
  }
}
