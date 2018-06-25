import 'dart:async';
import 'package:flutter/material.dart';
import './auth.dart';

class LoginScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginScreen({this.auth, this.onSignedIn});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Email: $_email');
      print('Passsword: $_password');
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId =
          await widget.auth.signInWithEmailAndPassword(_email, _password);
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
        accentColor: Color(0xFFC54C82),
        primaryColor: Color(0xFFC54C82),
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            'jaga sehat',
            style: TextStyle(
              color: Color(0xFFC54C82),
              fontSize: 26.0,
              fontFamily: 'Kelvetica',
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("assets/background/login_background.jpg"),
              fit: BoxFit.cover,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          height: 160.0,
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/logo/logo3.png'),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                          ),
                          child: Text(
                            'Aplikasi Admin',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Color(0xFFC54C82),
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 24.0,
                                    right: 24.0,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (value) => _email = value,
                                    validator: (value) => value.isEmpty ? 'Email harus diisi' : null,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 24.0,
                                    right: 24.0,
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    onSaved: (value) => _password = value,
                                    keyboardType: TextInputType.text,
                                    validator: (val) => val.isEmpty
                                        ? 'Katasandi tidak boleh kosong.'
                                        : null,
                                    decoration:
                                        InputDecoration(labelText: "Katasandi"),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 20.0,
                                      bottom: 12.0),
                                  child: RaisedButton(
                                    color: Color(0xFFC54C82),
                                    child: Text(
                                      'Masuk',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: validateAndSubmit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Form(
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: "Katasandi"),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 100.0,
                color: Color(0xFFC54C82),
                textColor: Colors.white,
                child: Text('Masuk'),
                onPressed: () => {},
                splashColor: Color(0xFFC54C82),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),
*/
