import 'package:flutter/material.dart';

class TranspositionShiper extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<TranspositionShiper> {
  final TextEditingController _passwordController = TextEditingController();
  String _encryptedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transposition Cipher Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _encryptedPassword = encrypt(_passwordController.text, 3);
                });
              },
              child: Text('Encrypt'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Encrypted Password'),
                      content: Text(_encryptedPassword),
                    );
                  },
                );
              },
              child: Text('Show Encrypted Password'),
            ),
            ElevatedButton(
              onPressed: () {
                String decryptedPassword = decrypt(_encryptedPassword, 3);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Decrypted Password'),
                      content: Text(decryptedPassword),
                    );
                  },
                );
              },
              child: Text('Decrypt'),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk mengenkripsi pesan dengan transposition cipher
String encrypt(String message, int key) {
  String encryptedMessage = '';
  int numRows = ((message.length - 1) / key).floor() + 1;

  for (int i = 0; i < numRows; i++) {
    for (int j = 0; j < key; j++) {
      int index = i + j * numRows;
      if (index < message.length) {
        encryptedMessage += message[index];
      } else {
        encryptedMessage += ' ';
      }
    }
  }
  print(encryptedMessage);
  return encryptedMessage;
}

// Fungsi untuk mendekripsi pesan dengan transposition cipher
String decrypt(String message, int key) {
  String decryptedMessage = '';
  int numRows = ((message.length - 1) / key).floor() + 1;

  for (int i = 0; i < key; i++) {
    for (int j = 0; j < numRows; j++) {
      int index = i * numRows + j;
      if (index < message.length) {
        decryptedMessage += message[index];
      }
    }
  }
  print(decryptedMessage);
  return decryptedMessage;
}
