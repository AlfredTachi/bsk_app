import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bsk_app/screens/quizpage/resultpage.dart';
import 'package:bsk_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/shared/loading.dart';
import 'package:bsk_app/shared/dialogs.dart';
import 'package:flutter/services.dart';

import 'progress_painter.dart';
import 'dart:ui';

class Getjson extends StatelessWidget {
  // "kapitelName" as a parameter
  final String kapitelName;
  Getjson({@required this.kapitelName});
  static String jsonFileToLoad;

  // function sets the asset to a particular JSON file
  setJsonFile() {
    if (kapitelName == 'Einführung & Grundlagen') {
      jsonFileToLoad = 'assets/01_intro.json';
    } else if (kapitelName == 'Prozesse und Threads') {
      jsonFileToLoad = 'assets/02_process.json';
    } else if (kapitelName == 'IPC & Race Conditions') {
      jsonFileToLoad = 'assets/03_ipc.json';
    } else if (kapitelName == 'Scheduling') {
      jsonFileToLoad = 'assets/04_scheduling.json';
    } else if (kapitelName == 'Speicherverwaltung') {
      jsonFileToLoad = 'assets/05_storage.json';
    } else if (kapitelName == 'Dateisysteme') {
      jsonFileToLoad = 'assets/06_fileSystem.json';
    } else if (kapitelName == 'IT-Sicherheit') {
      jsonFileToLoad = 'assets/07_itsec.json';
    } else {
      jsonFileToLoad = 'assets/08_exam.json';
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

class _QuizpageState extends State<Quizpage>
    with SingleTickerProviderStateMixin {
  final myData;
  _QuizpageState(this.myData);

  // colors for different status
  Color _colorToShow = Colors.indigoAccent;
  Color _right = Colors.green;
  Color _wrong = Colors.red;
  int points = 0;
  int i = 1;
  var choosQuesRandArray;
  // variable to iterate
  int j = 1;
  int _timer = 30;
  String _showTimer = '30';

  bool _cancelTimer = false;
  bool _answerIsNotChecked = true;

  Map<String, Color> _buttonColor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  int numberOfQuestion = 10;
  int totalPoints = 10 * 5;

  /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  double _percentage;
  double _nextPercentage;
  AnimationController _progressAnimationController;

  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..addListener(
        () {
          setState(() {
            _percentage = lerpDouble(_percentage, _nextPercentage,
                _progressAnimationController.value);
          });
        },
      );
  }

  publishProgress() {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 1.0;
      if (_nextPercentage > 30.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: Text(
          _showTimer,
          style: TextStyle(
              color: Colors.indigo[900],
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quando'),
        ),
      ),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.indigoAccent,
          percentageCompletedCircleColor: Colors.white,
          completedPercentage: _percentage,
          circleWidth: 25.0),
    );
  }
  /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

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
    // startProgress();
    super.initState();

    //
    _percentage = 0.0;
    _nextPercentage = 0.0;
    initAnimationController();
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
        if (_timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (_cancelTimer == true) {
          t.cancel();
        } else {
          publishProgress();
          _timer -= 1;
        }
        _showTimer = _timer.toString();
      });
    });
  }

  void nextQuestion() async {
    _answerIsNotChecked = true;
    _cancelTimer = false;
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = 30;
    setState(() {
      if (j < numberOfQuestion) {
        i = choosQuesRandArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Resultpage(
            points: points,
            totalPoints: totalPoints,
          ),
        ));
      }
      _buttonColor["a"] = Colors.indigoAccent;
      _buttonColor["b"] = Colors.indigoAccent;
      _buttonColor["c"] = Colors.indigoAccent;
      _buttonColor["d"] = Colors.indigoAccent;
    });
    starTimer();
  }

  Future<void> checkAnswer(String k) async {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      points += 5;
      _colorToShow = _right;
    } else {
      _colorToShow = _wrong;
    }
    setState(() {
      _buttonColor[k] = _colorToShow;
      _cancelTimer = true;
    });
    _answerIsNotChecked = false;
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
            _answerIsNotChecked ? checkAnswer(k) : _answerIsNotChecked = false,
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
        color: _buttonColor[k],
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
          backgroundColor: Colors.indigo[100],
          body: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                  highlightElevation: 20.0,
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  child: Padding(
                      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.indigo,
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)
                          /*topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)*/
                          )),
                  onPressed: () async {
                    await Dialogs.yesNoDialog(context, 'BskQuiz abbrechen',
                        'Quiz abbrechen?', null, '/homepage');
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
                        color: Colors.indigo[900],
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
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: progressView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
