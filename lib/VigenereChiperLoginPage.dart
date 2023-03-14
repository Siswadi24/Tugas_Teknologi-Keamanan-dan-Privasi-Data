import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _encrypt(String plainText, String key) {
    String encryptedText = '';
    int index = 0;
    for (int i = 0; i < plainText.length; i++) {
      int plainCharCode = plainText.codeUnitAt(i);
      if (plainCharCode >= 65 && plainCharCode <= 90) {
        // hanya mengenkripsi huruf besar
        int keyCharCode = key.codeUnitAt(index % key.length);
        int encryptedCharCode =
            ((plainCharCode - 65) + (keyCharCode - 65)) % 26 +
                65; // menggunakan modulus 26
        encryptedText += String.fromCharCode(encryptedCharCode);
        index++;
      } else if (plainCharCode >= 97 && plainCharCode <= 122) {
        // hanya mengenkripsi huruf kecil
        int keyCharCode = key.codeUnitAt(index % key.length);
        int encryptedCharCode =
            ((plainCharCode - 97) + (keyCharCode - 97)) % 26 +
                97; // menggunakan modulus 26
        encryptedText += String.fromCharCode(encryptedCharCode);
        index++;
      } else if (plainText.length - i <= 3) {
        // menambahkan "049" pada 3 karakter terakhir
        String padding = "049";
        int paddingIndex = padding.length - (plainText.length - i);
        encryptedText += padding.substring(paddingIndex);
        break;
      } else {
        encryptedText += plainText[i];
      }
    }
    return encryptedText;
  }

  String _decrypt(String cipherText, String key) {
    String decryptedText = '';
    int index = 0;
    for (int i = 0; i < cipherText.length; i++) {
      int cipherCharCode = cipherText.codeUnitAt(i);
      if (cipherCharCode >= 65 && cipherCharCode <= 90) {
        // hanya mendekripsi huruf besar
        int keyCharCode = key.codeUnitAt(index % key.length);
        int decryptedCharCode =
            ((cipherCharCode - 65) - (keyCharCode - 65) + 26) % 26 +
                65; // menggunakan modulus 26
        decryptedText += String.fromCharCode(decryptedCharCode);
        index++;
      } else if (cipherCharCode >= 97 && cipherCharCode <= 122) {
        // hanya mendekripsi huruf kecil
        int keyCharCode = key.codeUnitAt(index % key.length);
        int decryptedCharCode =
            ((cipherCharCode - 97) - (keyCharCode - 97) + 26) % 26 +
                97; // menggunakan modulus 26
        decryptedText += String.fromCharCode(decryptedCharCode);
        index++;
      } else {
        decryptedText += cipherText[i];
      }
    }
    return decryptedText;
  }

  void _onLoginPressed() {
    String username = _encrypt(_usernameController.text, 'my-secret-key');
    String password =
        '${_encrypt(_passwordController.text, 'my-secret-key')}049';

    // Do the login process here
    // ...

    // For example, print the decrypted username and password
    print(_decrypt(username, 'my-secret-key'));
    print(_decrypt(
        'Sebelum Enkripsi${password.substring(0, password.length - 3)}',
        'my-secret-key'));

    // Print the original password and the encrypted password
    print('Encrypted username: $username');
    print('Encrypted password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'Username'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onLoginPressed,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
