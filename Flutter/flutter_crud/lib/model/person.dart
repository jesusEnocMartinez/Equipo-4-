import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Person{
  String _id;
  String _name;
  String _lastName;
  String _direction;
  String _age;

  Person(this._id,this._name, this._lastName, this._direction, this._age);

  Person.map(dynamic obj){
    this._name = obj['name'];
    this._lastName = obj['lastName'];
    this._direction = obj['direction'];
    this._age = obj['age'];
  }

  String get id => _id;
  String get name => _name;
  String get lastName => _lastName;
  String get direction => _direction;
  String get age => _age;

  Person.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _lastName = snapshot.value['lastName'];
    _direction = snapshot.value['direction'];
    _age = snapshot.value['age'];
  }
}