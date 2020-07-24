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

final personReference = FirebaseDatabase.instance.reference().child('product');

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
        title: 'Personas BD',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personas Información'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position){
                return Column(
                  children: <Widget>[
                    Divider(height: 7.0,),
                    Row(
                      children : <Widget>[
                        Expanded(child: ListTile(title: Text('${items[position].name}',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 21.0,
                        ),
                        ),
                        subtitle:
                          Text('${items[position].direction}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 21.0,
                            )
                          ),
                        leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          radius: 17.0,
                          child: Text('${items[position].direction}',
                            style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 21.0
                            ),
                            ),
                           ),
                          ],
                        ),
                        onTap: () => _navigateToPersonInformation(context, items[position])),),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: () => _deletePerson(context, items[position], position)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.blueAccent,),
                            onPressed: () => _navigationPerson(context, items[position])),
              ],
              ),
              ],
                );
            }
          ),
          ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () => _createNewPerson(context),
        ),
      ),
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










