// Import required packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/drug_home.dart';
import 'forget_page.dart';
import 'wSignup_screen.dart';

class WLoginPage extends StatefulWidget {
  @override
  State<WLoginPage> createState() => _WLoginPageState();
}

class _WLoginPageState extends State<WLoginPage> {
  // Controllers for email and password input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Flags for UI state
  bool _obscureText = true; // To toggle password visibility
  bool _keepLoggedIn = false; // Checkbox for keeping the user logged in
  bool _loading = false; // To show loading indicator during login

  @override
  void dispose() {
    // Dispose controllers to free resources
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Function to handle login
  void _login() async {
    // Validate the form fields
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true; // Show loading indicator
    });

    try {
      // Attempt to sign in with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the home page on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DrugHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else {
        message = 'Login failed. Please try again later.';
      }

      // Show error message using Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Handle unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _loading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
            child: Form(
              key: _formKey, // Attach form key for validation
              child: Column(
                children: [
                  // Display a welcome image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/images/3.gif",
                      height: 300,
                    ),
                  ),

                  // Welcome text
                  Text(
                    "Welcome to Pakistan Pharmapeidia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Email input field
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),

                  // Password input field
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Toggle password visibility
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  // Forget password link
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forget Password'),
                        ],
                      ),
                    ),
                  ),

                  // Keep me logged in checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _keepLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            _keepLoggedIn = value!;
                          });
                        },
                      ),
                      Text('Keep me logged in'),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Login button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _login(); // Trigger login
                      }
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: _loading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Signup link
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 3),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WSignupPage()),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.deepPurple[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
