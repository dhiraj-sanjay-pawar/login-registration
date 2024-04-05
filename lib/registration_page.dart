import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Username',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _registerUser(context);
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
      version: 1,
    );

    await database.transaction((txn) async {
      await txn.insert(
        'users',
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await database.close();

    print('User registered: $username');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User registered successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('Username: $username\nPassword: $password'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
