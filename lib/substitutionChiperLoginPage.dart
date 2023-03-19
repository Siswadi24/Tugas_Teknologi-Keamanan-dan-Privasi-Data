import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPageSubstutionChiper extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageSubstutionChiper> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String encrypt(String password) {
    final random = Random();
    final alphabet = 'abcdefghijklmnopqrstuvwxyz';
    final substitution = alphabet.split('');
    substitution.shuffle(random);
    final letters = password.toLowerCase().split('');
    final encrypted =
        letters.map((c) => substitution[alphabet.indexOf(c)]).join('');
    print(encrypted);
    return encrypted;
  }

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final email = _emailController.text;
                final password = _passwordController.text;
                if (isValidEmail(email) && password.isNotEmpty) {
                  final encryptedPassword = encrypt(password);
                  // Lakukan autentikasi menggunakan email dan encryptedPassword
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Email atau password tidak valid."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
