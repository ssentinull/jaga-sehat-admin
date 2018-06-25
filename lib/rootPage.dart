import 'package:flutter/material.dart';
import './auth.dart';
import './homeScreen.dart';
import './loginScreen.dart';

class RootPage extends StatefulWidget{
  final BaseAuth auth;

  RootPage({this.auth});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus{
  signedIn,
  notSignedIn,
}

class _RootPageState extends State<RootPage>{
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = 
          userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;        
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;      
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;      
    });
  }

  @override
  Widget build(BuildContext context){
    switch (authStatus){
      case AuthStatus.notSignedIn:
        return LoginScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomeScreen(
          auth: widget.auth,
          onSignedOut: _signedOut,
        ); 
    }
    return null;
  }
}