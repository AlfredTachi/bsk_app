import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<String> images = [
    "images/01_BS_GL.png",
    "images/02_Process-thread.png",
    "images/03_ipc.png",
    "images/04_scheduler.png",
    "images/05_speicher.png",
    "images/06_file-system.png",
    "images/07_IT-Sicherheit.png",
    "images/examQuestion.png",
  ];

  Widget customcard(String kapitelname, String image){
    return Padding(
      padding: EdgeInsets.all(
        20.0,
      ),
      child: InkWell(
        onTap: (){
          debugPrint("Card Tapped");
        },
        child: Material(
          color: Colors.deepPurple,
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
                    kapitelname,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Dies ist eine Beschreibung \nkdhahskldaksdhlkashdkjsadhjk\nhakdhakhdkjdhkjad \njhdjagdgajhdjhg",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Alike",
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )
          )
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BskQuiz",
          style: TextStyle(
            fontFamily: "Qando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("Einführung und Grundlagen", images[0]),
          customcard("Prozesse und Threads", images[1]),
          customcard("IPC und Race Conditions", images[2]),
          customcard("Scheduling", images[3]),
          customcard("Speicherverwaltung", images[4]),
          customcard("Dateisysteme", images[5]),
          customcard("IT-Sicherheit", images[6]),
          customcard("Fragen aus alten Klausuren", images[7]),
        ],
      ),
    );
  }
}