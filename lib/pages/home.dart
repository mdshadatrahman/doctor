import 'package:doctor_appointment_app/pages/doctors.dart';
import 'package:doctor_appointment_app/pages/loginmethods.dart';
import 'package:doctor_appointment_app/services/auth.dart';
import 'package:doctor_appointment_app/utils/money_icons.dart';
import 'package:flutter/material.dart';
class AppointHome extends StatefulWidget {
  @override
  _AppointHomeState createState() => _AppointHomeState();
}

class _AppointHomeState extends State<AppointHome> {
  var authHandler = new Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],      
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text('Home'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await authHandler.signOut();
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[600],
                side: BorderSide(width: 2, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.cover
              ),
            ),

        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                homeElements(),
              ],
            ),
          ),
      ),
      );
  }
  Center homeElements() {
    return Center(
      child: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 100,
              padding: EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(
                  Money.stethoscope,
                  color: Colors.grey[500],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700].withOpacity(0.4),
                  side: BorderSide(width: 2.0, color: Colors.blue),
                ),
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => Doctors()));
                },
                label: Text(
                  'Doctors',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              padding: EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.lock_clock,
                  color: Colors.grey[500],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700].withOpacity(0.4),
                  side: BorderSide(width: 2.0, color: Colors.blue),
                ),
                onPressed: (){
                },
                label: Text(
                  'My Appointments',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              padding: EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.schedule,
                  color: Colors.grey[500],
                  ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700].withOpacity(0.4),
                  side: BorderSide(width: 2.0, color: Colors.blue),
                ),
                onPressed: (){},
                label: Text(
                  'My Schedules',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              padding: EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(
                  Money.money_bill_alt,
                  color: Colors.grey[500],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700].withOpacity(0.4),
                  side: BorderSide(width: 2.0, color: Colors.blue),
                ),
                onPressed: (){},
                label: Text(
                  'Make Payments',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
