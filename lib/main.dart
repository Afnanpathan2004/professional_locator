import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import the Login screen
import 'registration_screen.dart'; // Import the Registration screen
import 'home_screen.dart'; // Import the Home screen (if needed)
import 'main_page.dart'; // Import the MainPage file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Professional Locator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Setting the initial route to the Welcome page (MyHomePage)
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Welcome to Professional Locator'), // HomePage is the welcome screen
        '/register': (context) => RegistrationScreen(), // Register screen route
        '/login': (context) => LoginScreen(), // Login screen route
        '/home': (context) => HomeScreen(), // (Optional) Home screen if needed
        '/main': (context) => MainPage(), // MainPage as the dashboard after login
      },
    );
  }
}

// The Welcome screen (MyHomePage) where users can register or login
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Professional Locator!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigate to registration
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigate to login
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
