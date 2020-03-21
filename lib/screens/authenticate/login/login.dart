import 'package:bsk_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/services/auth.dart';
import 'package:bsk_app/shared/constants.dart';
import 'package:bsk_app/shared/widget_design_header_Form.dart';
import 'package:bsk_app/shared/loading.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final AuthService _firebaseAuth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text fiel state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: onWillPop,
        child: loading
            ? Loading()
            : Scaffold(
                backgroundColor: Colors.indigo,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      designHeaderForm('Einloggen'),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, 2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextFormField(
                                        validator: (value) => value.isEmpty
                                            ? 'Bitte Email eingeben'
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: emailInputDecoration,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) => value.length < 8
                                            ? 'Passwort muss 8+ Zeichen lang sein!'
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        obscureText: true,
                                        decoration: passwordInputDecoration,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: () => print(
                                      'Passwort-vergessen-Button angeklickt'),
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: Text(
                                    'Passwort vergessen?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quando',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0)),
                              SizedBox(
                                height: 15.0,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      dynamic result = await _firebaseAuth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Diese Anmeldeinformationen stimmt mit keinem der vorhandenen Accounts überein! Registrieren Sie sich';
                                          loading = false;
                                        });
                                      }
                                      print('User with uid: ' +
                                          result.uid +
                                          ' signed in!');
                                      Navigator.of(context)
                                          .pushReplacementNamed('/homepage');
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                },
                                elevation: 10.0,
                                color: Color.fromRGBO(143, 148, 251, 1),
                                splashColor: Colors.deepPurple,
                                highlightColor: Colors.deepPurple,
                                padding: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'Einloggen',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quando',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  User userFromFirebaseUser =
                                      await _firebaseAuth.anonLogin();
                                  if (userFromFirebaseUser == null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    print('error signing in');
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    print('anonym signed in');
                                    print(userFromFirebaseUser.uid);
                                    Navigator.of(context)
                                        .pushReplacementNamed('/homepage');
                                  }
                                },
                                elevation: 10.0,
                                color: Color.fromRGBO(143, 148, 251, 1),
                                splashColor: Colors.deepPurple,
                                highlightColor: Colors.deepPurple,
                                padding: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'Weiter als Gast',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quando',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _buildSignInWithText(),
                              _buildSocialBtnRow(),
                              SizedBox(
                                height: 20,
                              ),
                              _buildSignupBtn(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- ODER -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: 'Quando',
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Einloggen mit',
          style: TextStyle(color: Colors.white, fontFamily: 'Quando'),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 6),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Mit Facebook einloggen'),
            AssetImage(
              'images/fblogo.png',
            ),
          ),
          _buildSocialBtn(
            () async {
              _firebaseAuth.signInWithGoogle().whenComplete(() {
                Navigator.of(context).pushReplacementNamed('/homepage');
              });
            },
            AssetImage(
              'images/googlelogo.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/signuppage');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Noch keinen Account? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quando'),
            ),
            TextSpan(
              text: 'Registrieren',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quando'),
            ),
          ],
        ),
      ),
    );
  }
}
