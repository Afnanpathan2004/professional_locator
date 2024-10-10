import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registration Failed: ${e.toString()}')),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
