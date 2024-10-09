import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance of FirebaseAuth
  String email = '';
  String password = '';
  bool isLoading = false; // Loading state

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Wrap the inputs in a Form widget
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email format validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value; // Capture email input
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Password length validation
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value; // Capture password input
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator() // Show loading indicator
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true; // Start loading
                          });

                          try {
                            await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            ); // Register the user
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registration Successful!')),
                            );

                            // Clear the input fields
                            email = '';
                            password = '';
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registration Failed: ${e.toString()}')),
                            );
                          } finally {
                            setState(() {
                              isLoading = false; // Stop loading
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
