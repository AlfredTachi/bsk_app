import 'package:bsk_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/services/auth.dart';
import 'package:bsk_app/shared/constants.dart';
import 'package:bsk_app/shared/widget_design_header_Form.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {

  final AuthService _firebaseAuth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text fiel state
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            designHeaderForm('Registrieren'),
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
                                  value.isEmpty ? 'Bitte Benutzername eingeben' : null,
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: usernameInputDecoration
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
                                  value.isEmpty ? 'Bitte eine valide Email eingeben!' : null,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
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
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            dynamic result = await _firebaseAuth
                                .signUpWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Email nicht valide oder bereits verwendet!';
                                loading = false;
                              });
                            }
                            print('User created uid: ' + result.uid);
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
