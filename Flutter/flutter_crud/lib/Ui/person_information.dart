import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_crud/model/person.dart';

class PersonInformation extends StatefulWidget {
  final Person person;
  PersonInformation(this.person);
  @override
  _PersonInformationState createState() => _PersonInformationState();
}

final personReference = FirebaseDatabase.instance.reference().child('person');

class _PersonInformationState extends State<PersonInformation> {
  List<Person> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons Information'),
        backgroundColor: Colors.green,
      ),
          body: Container(
            height: 400.0,
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    new Text("Nombre : ${widget.person.name}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Apellidos : ${widget.person.lastName}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Dirección : ${widget.person.direction}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Edad : ${widget.person.age}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),

                  ],
                ),
              ),

            ),
          ),
    );
  }
}
