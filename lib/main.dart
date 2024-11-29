import 'package:inventory_app/pages/dashboard_page.dart';
import 'package:inventory_app/pages/login_page.dart';
import 'package:inventory_app/pages/register_page.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Some error has Occurred');
            } else if (snapshot.hasData) {
              final token = snapshot.data!.getString('token');
              if (token != null) {
                return const Home();
              } else {
                return const Login();
              }
            } else {
              return const Login();
            }
          }),
    );
  }
}
