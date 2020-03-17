import 'package:bsk_app/services/auth.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> yesNoDialog(BuildContext context, String title,
      String body, AuthService _firebaseAuth, String route) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              color: Colors.indigo,
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Nein'),
            ),
            RaisedButton(
              color: Colors.white,
              onPressed: () async {
                await _firebaseAuth.signOut();
                Navigator.of(context).pop(true);
                Navigator.of(context).pushReplacementNamed(route);
              },
              child: const Text(
                'Ja',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        );
      },
    );

    return (action != null) ? action : false;
  }
}
