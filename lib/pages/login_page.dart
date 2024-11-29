import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_app/helper/constant.dart';
import 'package:inventory_app/pages/dashboard_page.dart';
import 'package:inventory_app/pages/register_page.dart';
import 'package:inventory_app/widget/input_field.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../methods/api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void mostrarAlertaError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de inicio de sesión'),
          content: Text(context.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void loginUser() async {
    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/auth/login', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['data']['id']);
      await preferences.setString('name', response['data']['name']);
      await preferences.setString('email', response['data']['email']);
      await preferences.setString('token', response['access_token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      mostrarAlertaError(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = deviceWidth(context);
    double height = deviceHeight(context);
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spancer(h: height * 0.1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RotatedBox(
                      quarterTurns: 0,
                      child: Text(
                        'Iniciar Sesion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    spancer(
                      w: width * 0.05,
                    ),
                  ],
                ),
                spancer(
                  h: height * 0.15,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Ingrese correo electrónico',
                    labelText: 'Correo electrónico',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    // Rellena el campo
                    fillColor: Colors.grey[200],
                  ),
                ),
                spancer(
                  h: height * 0.02,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Ingrese contraseña',
                    labelText: 'Password',

                    prefixIcon: const Icon(Icons.password),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    // Rellena el campo
                    fillColor: Colors.grey[200],
                  ),
                ),
                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    loginUser();
                  },
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    padding: spacing(
                      h: 20,
                    ),
                    child: Container(
                      width: width * 0.3,
                      padding: spacing(
                        h: 5,
                        v: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Entrar',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          spancer(
                            w: 10,
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  children: [
                    Text(
                      'Primera Vez?',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 18,
                      ),
                    ),
                    spancer(w: 4),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        'Registrate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
