import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const usernameInputDecoration = InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(top: 14.0),
    hintText: 'Benutzername',
    hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Quando'),
    prefixIcon: Icon(Icons.person, color: Colors.deepPurpleAccent));

const emailInputDecoration = InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(top: 14.0),
    hintText: 'Email-Adresse',
    hintStyle: TextStyle(
      color: Color(0xFFBDBDBD),
      fontFamily: 'Quando',
    ),
    prefixIcon: Icon(Icons.email, color: Colors.deepPurpleAccent));

const passwordInputDecoration = InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(top: 14.0),
    hintText: 'Passwort',
    hintStyle: TextStyle(
      color: Color(0xFFBDBDBD),
      fontFamily: 'Quando',
    ),
    prefixIcon: Icon(Icons.lock, color: Colors.deepPurpleAccent));

// Override Back Button
DateTime backButtonPressedTime;
Future<bool> onWillPop() async {
  DateTime currentTime = DateTime.now();
  bool backButton = backButtonPressedTime == null ||
      currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

  if (backButton) {
    backButtonPressedTime = currentTime;
    Fluttertoast.showToast(
        msg: 'Zweimal klicken um die App zu verlassen!',
        backgroundColor: Colors.black,
        textColor: Colors.white);
    return false;
  }
  return true;
}

int numberOfQuestion = 10;
var randomArray;
var rand = new Random();

// function for choosing question randomly
  // Future<dynamic> choosingQuesRand() {
  //   var distinctIds = [];
  //   for(int i = 0; i < numberOfQuestion; i++){
  //     distinctIds.add(rand.nextInt(numberOfQuestion));
  //     randomArray = distinctIds.toSet().toList();
  //     if (randomArray.length < numberOfQuestion) {
  //       continue;
  //     } else {
  //       break;
  //     }
  //   }
  // return randomArray;
  // }