import 'package:firebase_database/firebase_database.dart';

class DatabaseActions{
  final DatabaseReference = FirebaseDatabase.instance.reference();

  void readData(){
    DatabaseReference.once().then((DataSnapshot snapshot){
      print('Data: ${snapshot.value}');
    });
  }
}