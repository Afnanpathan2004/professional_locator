import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'login_screen.dart'; // Import the new login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding for Firebase
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp()); // Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional Locator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Set the LoginScreen as the initial home screen
      home: MyHomePage(title: 'Welcome'), // Home page
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Ensure HomeScreen is defined
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Add a button to navigate to the Registration Screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigate to registration
              },
              child: const Text('Register'),
            ),
            // Add a button to navigate to the Login Screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigate to login
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Create the Registration Screen
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

// Ensure you define your HomeScreen widget here
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: const Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
