import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiftCipherLoginPage extends StatefulWidget {
  @override
  _ShiftCipherLoginPageState createState() => _ShiftCipherLoginPageState();
}

class _ShiftCipherLoginPageState extends State<ShiftCipherLoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _shiftCipher(String text, int shift) {
    String result = "";
    for (int i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        charCode = ((charCode - 65 + shift) % 26) + 65;
      } else if (charCode >= 97 && charCode <= 122) {
        charCode = ((charCode - 97 + shift) % 26) + 97;
      }
      String cipherCode = "";
      if (i >= text.length - 1) {
        cipherCode = "49";
      } else {
        cipherCode = String.fromCharCode(charCode);
      }
      result += cipherCode;
    }
    return result;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      // Shift cipher the password with a shift of 3
      String encryptedPassword = _shiftCipher(password, 3);

      // Print the original password and the encrypted password
      print("Original password: $password");
      print("Encrypted password: $encryptedPassword");

      // Authenticate user with encrypted password
      // ...
      // bool isAuthenticated = false;
      // if (username == "admin") {
      //   isAuthenticated = true;
      // }
      // if (isAuthenticated) {
      //   print(
      //       "Login success, username: $username, password: $encryptedPassword");
      // } else {
      //   print(
      //       "Login failed, username: $username, password: $encryptedPassword");
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shift Cipher Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
