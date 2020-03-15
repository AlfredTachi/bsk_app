import 'package:bsk_app/services/auth.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, no }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(BuildContext context, String title,
      String body, AuthService _firebaseAuth) async {
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
              onPressed: () => Navigator.of(context).pop(DialogAction.no),
              child: const Text('Nein'),
            ),
            RaisedButton(
              color: Colors.white,
              onPressed: () async {
                Navigator.of(context).pop(DialogAction.yes);
                await _firebaseAuth.signOut();
                Navigator.of(context).pushNamed('/loginpage');
                print('user signed out');
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

    return (action != null) ? action : DialogAction.no;
  }
}
