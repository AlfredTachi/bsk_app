import 'package:bsk_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

class MoreInfoBsk extends StatefulWidget {
  @override
  _MoreInfoBskState createState() => _MoreInfoBskState();
}

class _MoreInfoBskState extends State<MoreInfoBsk> {
  
  List<String> _descriptions = [
    'Forking und Prozessbäume',
    'Bsk Youtube Playlist',
    'Moodle',
    'ownCloud',
  ];

  List<String> _url = [
    'https://www.geeksforgeeks.org/fork-system-call',
    'https://www.youtube.com/playlist?list=PLW_T1H3VUi-4NJHebZEkq-5mrQslSieer',
    'https://moodle.hs-worms.de/moodle/',
    'https://cloud2.rz-fuhrmann.de/index.php/s/2w9MVu5Tx7EITbh?path=%2F',
  ];


  void _launcher(String url) async {
    try {
      await Launcher.launch(
        url,
        forceWebView: false,
        enableJavaScript: true,
      );
    } catch (e) {
      print(e.toString());
    }
    
  }

  Widget customcard(String description, String url) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: InkWell(
        onTap: () => _launcher(url),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.indigoAccent,
            elevation: 20.0,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              leading: Text(
                description,
                style: TextStyle(fontSize: 20.0, fontFamily: 'Quando', color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'hilfreiche Links',
              style: TextStyle(fontFamily: 'Quando'),
            ),
            centerTitle: true,
            elevation: 20.0,
            leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                }),
          ),
          body: ListView(
            children: <Widget>[
              customcard(_descriptions[0], _url[0]),
              customcard(_descriptions[1], _url[1]),
              customcard(_descriptions[2], _url[2]),
              customcard(_descriptions[3], _url[3]),
            ],
          ),
        ),
      ),
    );
  }
}
