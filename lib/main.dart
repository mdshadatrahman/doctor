import 'package:doctor_appointment_app/pages/home.dart';
import 'package:doctor_appointment_app/pages/loginmethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   Firebase.initializeApp();
  //   super.initState();
    
  // }

  @override
  Widget build(BuildContext context){
    
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Container(
            child: Text('Error'),
          );
        }
        if(snapshot.connectionState == ConnectionState.active){
          User user = snapshot.data;
          if(user == null){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'SFProDisplay',
              ),
              home: LoginScreen(),
            );
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'SFProDisplay',
              ),
              home: AppointHome(),
            );
        } 
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
