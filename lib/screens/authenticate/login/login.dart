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

  bool _loading = false;

  // text fiel state
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: WillPopScope(
          onWillPop: onWillPop,
          child: _loading
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
                                          color:
                                              Color.fromRGBO(143, 148, 251, 2),
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
                                              _email = value;
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
                                              ? 'Das Passwort muss mindesten 8 Zeichen enthalten!'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              _password = value;
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
                                        'Passwort-vergessen-Button pressed'),
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
                                Text(_error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14.0)),
                                SizedBox(
                                  height: 15.0,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _loading = true;
                                      });
                                      try {
                                        bool isConnected =
                                            await checkInternetConnectivity();
                                        dynamic result = await _firebaseAuth
                                            .signInWithEmailAndPassword(
                                                _email, _password);
                                        if (!isConnected) {
                                          setState(() {
                                            _error =
                                                'Keine Internetverbindung. Stelle eine Verbindung zum Internet her und versuche es erneut.';
                                            _loading = false;
                                          });
                                        } else if (result == null) {
                                          setState(() {
                                            _error =
                                                'Diese Anmeldeinformationen stimmen mit keinem der vorhandenen Accounts überein! Registrieren Sie sich';
                                            _loading = false;
                                          });
                                        } else {
                                          ///
                                          print(_email + ' signed in!');
                                          print('User with uid: ' +
                                              result.uid +
                                              ' ');
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/homepage');
                                        }
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
                                    try {
                                      User userFromFirebaseUser =
                                          await _firebaseAuth.anonLogin();
                                      if (userFromFirebaseUser == null) {
                                        setState(() {
                                          _loading = false;
                                        });
                                      } else {
                                        setState(() {
                                          _loading = true;
                                          _email = 'Anonymous';
                                        });

                                        ///
                                        print(_email);
                                        print('anonym signed in! uid: ' +
                                            userFromFirebaseUser.uid);
                                        Navigator.of(context)
                                            .pushReplacementNamed('/homepage');
                                      }
                                    } catch (e) {
                                      setState(() {
                                        _error =
                                            'Keine Internetverbindung. Stelle eine Verbindung zum Internet her und versuche es erneut.';
                                        _loading = false;
                                      });
                                      print(e.toString());
                                    }
                                  },
                                  elevation: 10.0,
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  splashColor: Colors.deepPurple,
                                  highlightColor: Colors.deepPurple,
                                  padding: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
              try {
                setState(() {
                    _loading = true;
                  });
                await _firebaseAuth.signInWithGoogle();
                if (_firebaseAuth.googleSignIn.currentUser == null) {
                  setState(() {
                    _loading = false;
                  });
                  print('error login with google!');
                } else {
                  setState(() {
                    _email = _firebaseAuth.getEmail();
                  });
                  print(_email);
                  Navigator.of(context).pushReplacementNamed('/homepage');
                }
              } catch (e) {
                setState(() {
                    _error = 'Keine Internetverbindung. Stelle eine Verbindung zum Internet her und versuche es erneut.';
                    _loading = false;
                  });
                print(e.toString());
              }
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
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quando'),
            ),
          ],
        ),
      ),
    );
  }
}
