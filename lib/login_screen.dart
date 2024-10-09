import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                email = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Login Successful!'),
                  ));
                  // Navigate to the main home screen or wherever you want after login
                  Navigator.pushReplacementNamed(context, '/home');  
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Login Failed'),
                  ));
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don’t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
