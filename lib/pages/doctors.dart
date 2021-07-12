import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/pages/docdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final firestoreInstance = FirebaseFirestore.instance;
  void printDataToConsol(){
      firestoreInstance.collection('doctors').get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //printDataToConsol();
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text('Doctors'),
        centerTitle: true,
      ),
      body: testDoctorList(),
      
    );
  }

  testDoctorList() {
    double c_width = MediaQuery.of(context).size.width*0.8;
    return FutureBuilder(
      future: firestoreInstance.collection('doctors').get(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[500],
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(snapshot.data.docs[index].data()['pic']),
                      backgroundColor: Colors.black,
                    ),
                    title: Container(
                      child: new Row(
                        children: [
                          Text(snapshot.data.docs[index].data()["name"],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      "Expart in: " + snapshot.data.docs[index].data()["expart"]
                      +". \nExpirence: "+ snapshot.data.docs[index].data()["exp"]
                      +"\n"+snapshot.data.docs[index].data()["degree"]
                      +"\nFees: "+snapshot.data.docs[index].data()["fees"]+"৳",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DocDetails(docId: snapshot.data.docs[index].id)));
                    },
                  ),
                ),
              );
            },

          );
        } else if(snapshot.connectionState == ConnectionState.none){
          return Text('No data');
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

}
