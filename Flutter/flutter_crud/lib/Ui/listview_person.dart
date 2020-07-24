import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_crud/Ui/person_screen.dart';
import 'package:flutter_crud/Ui/person_information.dart';
import 'package:flutter_crud/model/person.dart';

class ListViewPerson extends StatefulWidget {
  @override
  _ListViewPersonState createState() => _ListViewPersonState();
}

final personReference = FirebaseDatabase.instance.reference().child('person');

class _ListViewPersonState extends State<ListViewPerson> {

  List<Person> items;
  StreamSubscription<Event> _onPersonAddedSubscription;
  StreamSubscription<Event> _onPersonChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onPersonAddedSubscription = personReference.onChildAdded.listen(_onPersonAdded);
    _onPersonChangedSubscription = personReference.onChildChanged.listen(_onPersonChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onPersonAddedSubscription.cancel();
    _onPersonChangedSubscription.cancel();
  }

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRUD PERSONAS'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[200],          
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 12.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 7.0,
                    ),                    
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(                      
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].name}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].direction}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  onTap: () => _navigateToPersonInformation(
                                      context, items[position])),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showDialog(context, position),
                                ),
                                
                            //onPressed: () => _deleteProduct(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () =>
                                    _navigationPerson(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.deepPurple[50],
          ),
          backgroundColor: Colors.deepPurple[300],
          onPressed: () => _createNewPerson(context),
        ),
      ),
    );
  }

  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ELIMINAR'),
          content: Text('¿Seguro quiere eliminar?'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () =>
                  _deletePerson(context, items[position], position,),                                        
                    ),                   
            new FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onPersonAdded(Event event){
    setState(() {
      items.add(new Person.fromSnapShot(event.snapshot));
    });
  }

  void _onPersonChanged (Event event){
    var oldPersonValue = items.singleWhere((person) => person.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPersonValue)] = new Person.fromSnapShot(event.snapshot);
    });
  }
  

  void _deletePerson(BuildContext context, Person person, int position) async {
    await personReference.child(person.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToPersonInformation (BuildContext context, Person person) async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => PersonScreen(person)),
    );
  }

  void _navigationPerson(BuildContext context, Person person) async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => PersonInformation(person)),
  );
}
  void _createNewPerson(BuildContext context) async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => PersonScreen(Person(null, '', '', '', ''))),
    );
  }

}










