import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  // Initially hide password
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1.5,
        // shadowColor: AppColors.darkBlack,
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: TextStyle(
              fontSize: 24,
              // color: AppColors.successOpenTag,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              fontFamily: 'ExtraBold'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontFamily: 'SemiBoldText'),
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color:AppColors.successOpenTag,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                'Send Email',
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
    );
  }
}
