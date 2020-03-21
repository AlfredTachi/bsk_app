import 'package:flutter/material.dart';

class Resultpage extends StatefulWidget {
  int points;
  Resultpage({Key key, @required this.points}) : super(key: key);

  @override
  _ResultpageState createState() => _ResultpageState(points);
}

class _ResultpageState extends State<Resultpage> {

  int points;
  _ResultpageState(this.points);

  List<String> images = [
    'images/bad.png',
    'images/good.png',
    'images/success.png',
  ];

  String message;
  String image;

  @override
  void initState() {
    if (points < 20) {
      image = images[0];
      message = 'Du sollst dich anstrengen...\n' + 'Du hast $points Punkte erreicht !';
    } else if (points < 35) {
      image = images[1];
      message = 'Du kannst besser machen...\n' + 'Du hast $points Punkte erreicht !';
    } else {
      image = images[2];
      message = 'Gute Arbeit...\n' + 'Du hast $points Punkte erreicht !';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Ergebnis',
      )),
      body: Column(children: <Widget>[
        Expanded(
          flex: 8,
          child: Material(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: 300.0,
                      height: 300.0,
                      child: ClipRect(
                        child: Image(
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 15.0,
                    ),
                    child: Center(
                      child: Text(message,
                        style: TextStyle(fontFamily: 'Quando', fontSize: 20.0)),
                    ),
                  ),
                ],
          ))),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                },
                child: Text(
                  'Weiter',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                splashColor: Colors.indigo,
              )
            ],
          ),
        )
      ]),
    );
  }
}
