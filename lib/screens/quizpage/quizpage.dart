import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bsk_app/screens/quizpage/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/shared/loading.dart';
import 'package:flutter/services.dart';

class Getjson extends StatelessWidget {
  // "kapitelName" as a parameter
  String kapitelName;
  Getjson(this.kapitelName);
  String assetToLoad;

  // function sets the asset to a particular JSON file
  setAsset() {
    if (kapitelName == 'Einführung & Grundlagen') {
      assetToLoad = 'assets/python.json';
    } else if (kapitelName == 'Prozesse und Threads') {
      assetToLoad = 'assets/pt.json';
    } else if (kapitelName == 'IPC & Race Conditions') {
      assetToLoad = 'assets/ipc.json';
    } else if (kapitelName == 'Scheduling') {
      assetToLoad = 'assets/scheduling.json';
    } else if (kapitelName == 'Speicherverwaltung') {
      assetToLoad = 'assets/storage.json';
    } else if (kapitelName == 'Dateisysteme') {
      assetToLoad = 'assets/filesysteme.json';
    } else if (kapitelName == 'IT-Sicherheit') {
      assetToLoad = 'assets/itsec.json';
    } else {
      assetToLoad = 'assets/exam.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    // to avialable the string assetToLoad
    setAsset();
    // to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assetToLoad, cache: true),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Loading();
        } else {
          return Quizpage(myData: myData);
        }
      },
    );
  }
}

class Quizpage extends StatefulWidget {
  final dynamic myData;
  Quizpage({Key key, @required this.myData}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState(myData);
}

class _QuizpageState extends State<Quizpage> {
  final dynamic myData;
  _QuizpageState(this.myData);

  // colors for different status
  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int points = 0;
  int i = 1;
  // variable to iterate
  int j = 0;
  int timer = 60;
  String showTimer = '60';

  bool cancelTimer = false;

  Map<String, Color> buttonColor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  // function for choosing question randomly
  int numberOfQuestion = 10;
  var rand = new Random();
  int choosingQuesRandomly() {
    return rand.nextInt(numberOfQuestion + 1) +1;
  }

  // to start timer as this screen is created
  @override
  void initState() {
    starTimer();
    super.initState();
  }

  // overriding the setState function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starTimer() async {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer -= 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() async {
    cancelTimer = false;
    timer = 60;
    setState(() {
      if (j < numberOfQuestion - 1) {
        i = choosingQuesRandomly();
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Resultpage(points: points),
        ));
      }
      buttonColor["a"] = Colors.indigoAccent;
      buttonColor["b"] = Colors.indigoAccent;
      buttonColor["c"] = Colors.indigoAccent;
      buttonColor["d"] = Colors.indigoAccent;
    });
    starTimer();
  }

  void checkAnswer(String k) async {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      points += 5;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      buttonColor[k] = colorToShow;
      cancelTimer = true;
    });

    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        elevation: 20.0,
        onPressed: () async => checkAnswer(k),
        child: Text(
          myData[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Alike',
            fontSize: 16.0,
          ),
        ),
        color: buttonColor[k],
        splashColor: Colors.deepPurple[700],
        highlightColor: Colors.deepPurple[700],
        minWidth: 300.0,
        height: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text(
                    'BskQuiz',
                  ),
                  content:
                      Text('Sie können ab dieser Stufe nicht mehr zurück!'),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.indigo,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    )
                  ],
                ));
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(myData[0][i.toString()],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Quando',
                    )),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choiceButton('a'),
                      choiceButton('b'),
                      choiceButton('c'),
                      choiceButton('d'),
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quando'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
