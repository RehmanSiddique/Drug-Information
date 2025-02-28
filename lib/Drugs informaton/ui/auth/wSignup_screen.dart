
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/drug_home.dart';
import 'wLogin_screen.dart';

class WSignupPage extends StatefulWidget {
  @override
  State<WSignupPage> createState() => _WSignupPageState();
}

class _WSignupPageState extends State<WSignupPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup successful!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DrugHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password should be at least 6 characters.';
      } else {
        errorMessage = 'Signup failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(
                    image: AssetImage('assets/images/signup.jpeg'),
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: _loading ? null : _signup,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: _loading ? Colors.grey : Colors.deepPurple[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: _loading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WLoginPage()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                          ),
                        ),
                      ),
                    ],
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
