import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool _rememberMe = false;
    return Scaffold(
      // fix overflow when keyboard is opening
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
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
                            image: AssetImage("images/light-1.png")),
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
                            image: AssetImage("images/light-2.png")),
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
                            image: AssetImage("images/clock.png")),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          "Einloggen",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: "Quando",
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
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                hintText: "Email-Adresse",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: "Quando"),
                                prefixIcon: Icon(Icons.email,
                                    color: Colors.deepPurpleAccent)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                hintText: "Passwort",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: "Quando",
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.deepPurpleAccent)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () =>
                          print("Passwort-vergessen-Button angeklickt"),
                      padding: EdgeInsets.only(right: 0.0),
                      child: Text(
                        "Passwort vergessen?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Quando",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Checkbox(
                            value: _rememberMe,
                            checkColor: Colors.red,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Zugangsdaten speichern',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quando",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/profilpage");
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
                          "Einloggen",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quando",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/homepage");
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
                          "Weiter ohne Registrierung",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quando",
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
          ],
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
            fontFamily: "Quando",
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Einloggen mit',
          style: TextStyle(color: Colors.white, fontFamily: "Quando"),
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
              color: Colors.black26,
              offset: Offset(0, 2),
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
            () => print('Mit Google einloggen'),
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
      onTap: () => print('Registrieren Button angeklickt'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Noch keinen Account? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Quando"),
            ),
            TextSpan(
              text: 'Registrieren',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quando"),
            ),
          ],
        ),
      ),
    );
  }
}
