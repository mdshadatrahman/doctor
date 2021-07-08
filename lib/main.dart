import 'package:doctor_appointment_app/pages/loginmethods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Container(
            child: Text('Error'),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
              title: 'Doctor Appointment App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'SFProDisplay',
              ),
              home: LoginScreen(),
          );
        } else {
          return Container(
            width: 0,
            height: 0,
          );
        }
      },
    );
  }
}
