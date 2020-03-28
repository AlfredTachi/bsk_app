import 'package:bsk_app/shared/constants.dart';
import 'package:flutter/material.dart';

class Resultpage extends StatefulWidget {
  final points;
  final totalPoints;
  Resultpage({Key key, @required this.points, @required this.totalPoints})
      : super(key: key);

  @override
  _ResultpageState createState() => _ResultpageState(points, totalPoints);
}

class _ResultpageState extends State<Resultpage> {
  var totalPoints;
  var points;
  _ResultpageState(this.points, this.totalPoints);

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
      message = 'Du sollst dich anstrengen...\n' +
          'Du hast $points/$totalPoints Punkte erreicht !';
    } else if (points < 35) {
      image = images[1];
      message = 'Du kannst besser machen...\n' +
          'Du hast $points/$totalPoints Punkte erreicht !';
    } else {
      image = images[2];
      message =
          'Gute Arbeit...\n' + 'Du hast $points/$totalPoints Punkte erreicht !';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
              child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.indigo,
              centerTitle: true,
              title: Text(
                'Ergebnis',
                style: TextStyle(fontFamily: 'Quando'),
              )),
          body: Column(children: <Widget>[
            Expanded(
              flex: 8,
              child: Material(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                        gradient: LinearGradient(
                            colors: [Colors.indigo, Colors.indigoAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                          ),
                          Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.7,
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
                                  style: TextStyle(
                                      fontFamily: 'Quando',
                                      fontSize: 20.0,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ))),
            ),
            Expanded(
              flex: 2,
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
                        fontFamily: 'Quando',
                        fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
