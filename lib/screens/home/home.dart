import 'package:bsk_app/screens/quizpage/quizpage.dart';
import 'package:bsk_app/services/auth.dart';
import 'package:bsk_app/shared/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/shared/dialogs.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _firebaseAuth = AuthService();

  List<String> images = [
    'images/01_BS_GL.png',
    'images/02_Process-thread.png',
    'images/03_ipc.png',
    'images/04_scheduler.png',
    'images/05_speicher.png',
    'images/06_file-system.png',
    'images/07_IT-Sicherheit.png',
    'images/examQuestion.png',
  ];

  List<String> descriptions = [
    'Geschichte, Grundbegriffe und Arten von Betriebssystemen.',
    'Parallelität und Speedup, Arten von Prozessen, Systemaufrufe, Prozesserzeugung, -terminierung und -zustände, Threads und Multithreading.',
    'IPC - Pipes, FIFOs, Shared Memory, Signale - und Race Condition, Semaphore/Mutex, Barrieren, Monitoren.',
    'Scheduling, Optimierungsproblem des Scheduling Algorithmen.',
    'Speicherverwaltung, Seitenersetzungsalgorithmen.',
    'Grundlagen der Dateisysteme',
    'Terminologie, Zugriffsschutz, verdeckte Kanäle, Grundlagen der Authentifizierung, Secure Coding.',
    'Zusammenfassung der Fragen aus alten.',
  ];

  Widget customcard(String kapitelName, String image, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: InkWell(
          onTap: () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Getjson(kapitelName: kapitelName),
            ));
          },
          child: Material(
              color: Colors.indigoAccent,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        child: ClipOval(
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      kapitelName,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontFamily: 'Quando',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'Alike',
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )))),
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
          appBar: AppBar(
            leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                }),
            title: Text(
              'BskQuiz',
              style: TextStyle(
                fontFamily: 'Qando',
              ),
            ),
            elevation: 20.0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await Dialogs.yesNoDialog(
                      context,
                      'Aussloggen',
                      'Möchtest du dich wircklich aussloggen?',
                      _firebaseAuth,
                      '/loginpage');
                },
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              customcard('Einführung & Grundlagen', images[0], descriptions[0]),
              customcard('Prozesse und Threads', images[1], descriptions[1]),
              customcard('IPC und Race Conditions', images[2], descriptions[2]),
              customcard('Scheduling', images[3], descriptions[3]),
              customcard('Speicherverwaltung', images[4], descriptions[4]),
              customcard('Dateisysteme', images[5], descriptions[5]),
              customcard('IT-Sicherheit', images[6], descriptions[6]),
              customcard('Alte Klausurfragen', images[7], descriptions[7]),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.white,
            backgroundColor: Colors.indigo,
            buttonBackgroundColor: Colors.white,
            height: 50,
            items: <Widget>[
              Icon(Icons.book, size: 20, color: Colors.indigo),
              Icon(Icons.info_outline, size: 20, color: Colors.indigo),
              Icon(Icons.account_circle, size: 20, color: Colors.indigo)
            ],
            animationDuration: Duration(
              milliseconds: 200,
            ),
            index: 1,
            onTap: (index) {
              if (index == 0) {
                Navigator.of(context).pushReplacementNamed('/viewonedrivepage');
              } else if (index == 1) {
                Navigator.of(context).pushReplacementNamed('/moreinfopage');
              } else if (index ==2) {
                Navigator.of(context).pushReplacementNamed('/profilepage');
              }
              debugPrint('Currrent Index is $index');
            },
          ),
        ),
      ),
    );
  }
}
