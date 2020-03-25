import 'dart:io';

import 'package:bsk_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _firebaseAuth = AuthService();
  File _image;

  @override
  Widget build(BuildContext context) {
    // function to get picture from the gallery
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    // function to upload the picture in firebase
    Future upLoadPicture(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile picture uploaded!')));
        print('Profile picture uploaded!');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: 'Quando'),
        ),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.indigo[200], Colors.indigo[500]],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    getImage().whenComplete((){
                      upLoadPicture(context);
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple[900],
                    radius: 130.0,
                    child: ClipOval(
                      child: SizedBox(
                        width: 250.0,
                        height: 250.0,
                        child: (_image != null)
                            ? Image.file(_image, fit: BoxFit.cover)
                            : Image.asset('images/splash.png',
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'NAME',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Taroal',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 25,
                      color: Colors.deepPurple[900],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'EMAIL',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'taroal@web.de',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 25,
                      color: Colors.deepPurple[900],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'LAST SCORE',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '.../50',
                  style: TextStyle(
                      fontFamily: 'Quando',
                      fontSize: 25,
                      color: Colors.deepPurple[900],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: () {
                    _firebaseAuth.signOut();
                    Navigator.of(context).pushNamed('/loginpage');
                  },
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ausloggen',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
