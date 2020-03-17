import 'package:flutter/material.dart';

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
