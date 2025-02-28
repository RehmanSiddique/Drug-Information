import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  bool _obscureText = true;
  bool _obscureText1 = true;
  // Initially hide password
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1.5,
        // shadowColor:  ,
        centerTitle: true,
        title: Text(
          'Change Password',
          style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              fontFamily: 'ExtraBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontFamily: 'SemiBoldText'),
                    border: OutlineInputBorder(),
                    labelText: 'Old Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontFamily: 'SemiBoldText'),
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      // color: AppColors.successOpenTag,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontFamily: 'SemiBoldText'),
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility : Icons.visibility_off,
                      // color: AppColors.successOpenTag,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText1,
              ),
              SizedBox(height: 20),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: AppColors.successOpenTag,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'ExtraBoldText',
                      wordSpacing: 2.0),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
