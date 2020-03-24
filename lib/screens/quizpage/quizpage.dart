import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bsk_app/screens/quizpage/resultpage.dart';
import 'package:bsk_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/shared/loading.dart';
import 'package:bsk_app/shared/dialogs.dart';
import 'package:flutter/services.dart';

class Getjson extends StatelessWidget {
  // "kapitelName" as a parameter
  final String kapitelName;
  Getjson({@required this.kapitelName});
  static String jsonFileToLoad;

  // function sets the asset to a particular JSON file
  setJsonFile() {
    if (kapitelName == 'Einführung & Grundlagen') {
      jsonFileToLoad = 'assets/python.json';
    } else if (kapitelName == 'Prozesse und Threads') {
      // jsonFileToLoad = 'assets/pt.json';
      jsonFileToLoad = 'assets/python1.json';
    } else if (kapitelName == 'IPC & Race Conditions') {
      // jsonFileToLoad = 'assets/ipc.json';
      jsonFileToLoad = 'assets/python2.json';
    } else if (kapitelName == 'Scheduling') {
      // jsonFileToLoad = 'assets/scheduling.json';
      jsonFileToLoad = 'assets/python3.json';
    } else if (kapitelName == 'Speicherverwaltung') {
      // jsonFileToLoad = 'assets/storage.json';
      jsonFileToLoad = 'assets/python4.json';
    } else if (kapitelName == 'Dateisysteme') {
      // jsonFileToLoad = 'assets/filesysteme.json';
      jsonFileToLoad = 'assets/python5.json';
    } else if (kapitelName == 'IT-Sicherheit') {
      // jsonFileToLoad = 'assets/itsec.json';
      jsonFileToLoad = 'assets/python6.json';
    } else {
      // jsonFileToLoad = 'assets/exam.json';
      jsonFileToLoad = 'assets/python7.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    // to avialable the string assetToLoad
    setJsonFile();
    // to load and decode JSON
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString(jsonFileToLoad, cache: true),
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
  final myData;
  Quizpage({Key key, @required this.myData}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState(myData);
}

class _QuizpageState extends State<Quizpage> {
  final myData;
  _QuizpageState(this.myData);

  // colors for different status
  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int points = 0;
  int i = 1;
  var choosQuesRandArray;
  // variable to iterate
  int j = 1;
  int timer = 60;
  String showTimer = '60';

  bool cancelTimer = false;
  bool answerIsNotChecked = true;

  Map<String, Color> buttonColor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  int numberOfQuestion = 10;
  int totalPoints = 10 * 5;

  // function for choosing question randomly
  void choosingQuesRandomlyFunc() {
    var distinctIds = [];
    var rand = new Random();
    while (true) {
      distinctIds.add(rand.nextInt(numberOfQuestion) + 1);
      choosQuesRandArray = distinctIds.toSet().toList();
      if (choosQuesRandArray.length < numberOfQuestion) {
        continue;
      } else {
        break;
      }
    }
    i = choosQuesRandArray[0];
  }

  // to start timer as this screen is created
  @override
  void initState() {
    choosingQuesRandomlyFunc();
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
    answerIsNotChecked = true;
    cancelTimer = false;
    timer = 60;
    setState(() {
      if (j < numberOfQuestion) {
        i = choosQuesRandArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Resultpage(points: points, totalPoints: totalPoints,),
        ));
      }
      buttonColor["a"] = Colors.indigoAccent;
      buttonColor["b"] = Colors.indigoAccent;
      buttonColor["c"] = Colors.indigoAccent;
      buttonColor["d"] = Colors.indigoAccent;
    });
    starTimer();
  }

  Future<void> checkAnswer(String k) async {
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
    answerIsNotChecked = false;
    await Future.delayed(Duration(seconds: 1), nextQuestion);
    // Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        elevation: 20.0,
        onPressed: () =>
            answerIsNotChecked ? checkAnswer(k) : answerIsNotChecked = false,
        child: Text(
          myData != null
              ? myData[1][i.toString()][k]
              : '!! Daten werden geladen ...',
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
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.indigo,
          body: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                  child: Padding(
                      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.white,
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  onPressed: () async {
                    await Dialogs.yesNoDialog(
                        context,
                        'BskQuiz abbrechen',
                        'Quiz abbrechen?',
                        null,
                        '/homepage');
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      myData != null
                          ? myData[0][i.toString()]
                          : '!! Daten werden geladen ...',
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
                      showTimer ?? 'Timer wird gestartet...',
                      style: TextStyle(
                        color: Colors.white,
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
      ),
    );
  }
}
