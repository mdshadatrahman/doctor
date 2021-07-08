import 'package:doctor_appointment_app/pages/loginwithemailandpassword.dart';
import 'package:doctor_appointment_app/pages/home.dart';
import 'package:doctor_appointment_app/pages/signup.dart';
import 'package:doctor_appointment_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var authHandler = new Auth();
  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: Text('Login'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey[700]),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              }, 
              child: Text('Register'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(            
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: Column(            
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[700].withOpacity(0.1),
                          side: BorderSide(width: 2, color: Colors.blue),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithEmailAndPassword()));
                        },
                        child: Text(
                          'Login with Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[700].withOpacity(0.1),
                          side: BorderSide(width: 2, color: Colors.blue),
                        ),
                        onPressed: () async{
                          await authHandler.handleAnonLogin();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointHome()));
                        },
                        child: Text(
                          'Guest Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}