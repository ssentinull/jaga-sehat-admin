import './auth.dart';
import './dataScreen.dart';
import './statisticsScreen.dart';
import './reusableWidgets.dart';
import 'firestoreImage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  HomeScreen({this.auth, this.onSignedOut});

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var logoutButtons = IconButton(
      icon: Icon(
        Icons.exit_to_app,
        color: Color(0xFFC54C82),
      ),
      onPressed: _signOut,
    );

    var dataRoute =
        MaterialPageRoute(builder: (BuildContext context) => DataScreen());

    var statistikRoute = MaterialPageRoute(
        builder: (BuildContext context) => StatisticsScreen());
        
    var downloadRoute = MaterialPageRoute(
        builder: (BuildContext context) => MyHomePage());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
      ),
      home: Scaffold(
        appBar: CustomAppBar2(
          logoutButton: logoutButtons,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: ListView(
              children: <Widget>[
                CustomButton(
                    'Statistik', Icons.assessment, 0xFFC54C82, statistikRoute),
                CustomButton('Data Individu', Icons.assignment_ind, 0xFF512E67,
                    dataRoute),
                CustomButton('Unggah', Icons.cloud_download, 0xFF512E67,
                    downloadRoute),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  int hexVal;
  String text;
  IconData icon;
  MaterialPageRoute route;

  CustomButton(this.text, this.icon, this.hexVal, this.route);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: RaisedButton(
        elevation: 2.0,
        padding: EdgeInsets.all(40.0),
        color: Color(hexVal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              this.icon,
              size: 60.0,
              color: Colors.white,
            ),
            Text(
              '$text',
              style: TextStyle(color: Colors.white, fontSize: 32.0),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(this.route);
        },
      ),
    );
  }
}
