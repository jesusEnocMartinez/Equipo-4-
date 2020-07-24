import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_crud/Ui/person_information.dart';
import 'package:flutter_crud/model/person.dart';

class PersonScreen extends StatefulWidget {
  final Person person;
  PersonScreen (this.person);
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('person');
class _PersonScreenState extends State<PersonScreen> {
  List<Person> items;

  TextEditingController _nameController;
  TextEditingController _lasNameController;
  TextEditingController _directionController;
  TextEditingController _ageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.person.name);
    _lasNameController = new TextEditingController(text: widget.person.name);
    _directionController = new TextEditingController(text: widget.person.name);
    _ageController= new TextEditingController(text: widget.person.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Personas'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _lasNameController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.border_color), labelText: 'Apellidos'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _directionController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.list), labelText: 'Domicilio'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _ageController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.stop), labelText: 'Edad'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.person.id != null) {
                        productReference.child(widget.person.id).set({
                          'name': _nameController.text,
                          'lastName': _lasNameController.text,
                          'direction': _directionController.text,
                          'age': _ageController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        productReference.push().set({
                          'name': _nameController.text,
                          'lastName': _lasNameController.text,
                          'direction': _directionController.text,
                          'age': _ageController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.person.id != null)
                        ? Text('Actualizar')
                        : Text('Añadir')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}