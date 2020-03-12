import 'package:bsk_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/services/auth.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  // String _username, _email, _password;

  final AuthService _firebaseAuth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text fiel state
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/light-1.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/light-2.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/clock.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          'Registrieren',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Quando',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Enter an username' : null,
                              onChanged: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  hintText: 'Benutzername',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Quando'),
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.deepPurpleAccent)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Enter an email' : null,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  hintText: 'Email-Adresse',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Quando',
                                  ),
                                  prefixIcon: Icon(Icons.email,
                                      color: Colors.deepPurpleAccent)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) => value.length < 8
                                  ? 'Enter a password 8+ chars long'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  hintText: 'Passwort',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Quando',
                                  ),
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors.deepPurpleAccent)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            User user = await _firebaseAuth
                                .signUpWithEmailAndPassword(email, password);
                            if (user == null) {
                              setState(() {
                                error =
                                    'Email nicht valide oder bereits verwendet!';
                              });
                            }
                            print('User created uid: ' + user.uid);
                            Navigator.of(context).pushNamed('/homepage');
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
                            'Registrieren',
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
                      height: 12.0,
                    ),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0)),
                    SizedBox(
                      height: 40,
                    ),
                    _buildSignInBtn()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/loginpage');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Schon registriert? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quando'),
            ),
            TextSpan(
              text: 'Sich einloggen',
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
