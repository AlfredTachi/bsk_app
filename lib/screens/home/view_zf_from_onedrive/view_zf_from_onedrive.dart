import 'dart:async';
import 'package:bsk_app/shared/constants.dart';
import 'package:bsk_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SummaryDir extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SummaryDirState();
}

class SummaryDirState extends State<SummaryDir> {
  num _viewIndex = 0;
  bool _pageIsLoaded = false;

  void pageReload() {
    setState(() {
      Navigator.popAndPushNamed(context, '/viewonedrivepage');
    });
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _pageIsLoaded = true;
      _viewIndex = 1;
    });
  }

  void checkTimeOut(String url) async {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        if (_pageIsLoaded == false) {
          _viewIndex = 2;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.blue[700],
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.blue[700]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                          }),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 3, bottom: 3),
                            child: Text(
                              "hilfreiche Dateien",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Quando',
                                  color: Colors.white),
                            ))),
                  ],
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: _viewIndex,
                  children: <Widget>[
                    Loading(),
                    WebView(
                      initialUrl:
                          'https://hsworms-my.sharepoint.com/:f:/g/personal/alfred_tachi_hsworms_onmicrosoft_com/Ev0kjsfN77xArMaFIRcPY7kBjGGWYxjf31ZlpnHbzqFevA?e=8PG0e7',
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageStarted: checkTimeOut,
                      onPageFinished: pageFinishedLoading,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Text(
                              "Bitte Internetverbindung prüfen!",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Quando',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                              alignment: Alignment.center,
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              onPressed: () {
                                pageReload();
                              })
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
