import 'package:doctor_appointment_app/pages/home.dart';
import 'package:doctor_appointment_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithEmailAndPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var authHandler = new Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text('Login with Email'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    decorationColor: Colors.white,
                ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.white,
                ),
                  controller: _passwordController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[700].withOpacity(0.7),
                  ),
                  onPressed: () async{
                    authHandler.handleSignInEmail(_emailController.text, _passwordController.text)
                        .then((User user){
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new AppointHome()));

                    }).catchError((e) => Fluttertoast.showToast(
                      msg: '$e',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    ));
                  },
                  child: Text('Log in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
