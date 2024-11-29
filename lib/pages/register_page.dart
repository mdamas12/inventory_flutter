import 'dart:convert';

import 'package:inventory_app/helper/constant.dart';
import 'package:inventory_app/pages/dashboard_page.dart';
import 'package:inventory_app/pages/login_page.dart';
import 'package:inventory_app/widget/input_field.dart';
import 'package:flutter/material.dart';

import '../methods/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void mostrarAlertaError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error al intentar registrar usuario'),
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

  void registerUser() async {
    final data = {
      'name': username.text.toString(),
      'email': email.text.toString(),
      'password': password.text.toString(),
      'role': 'customer',
    };
    final result = await API().postRequest(route: '/auth/register', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 201) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(),
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
                        'Restro de Usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
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
                  controller: username,
                  decoration: InputDecoration(
                    hintText: 'nombre de usuario',
                    labelText: 'nombre completo',

                    prefixIcon: const Icon(Icons.person),

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
                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    registerUser();
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
                            'Registrar',
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
                      'Have we met before?',
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
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
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
