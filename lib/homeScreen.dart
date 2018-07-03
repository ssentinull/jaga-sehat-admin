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

    var downloadRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
      ),
      home: Scaffold(
        appBar: CustomAppBar2(
          logoutButton: logoutButtons,
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Center(
              child: orientation == Orientation.portrait
              ? Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(true, 'Statistik', Icons.assessment, 0xFFC54C82,
                        statistikRoute),
                    CustomButton(true, 'Data Individu', Icons.assignment_ind,
                        0xFF512E67, dataRoute),
                    CustomButton(true, 'Unduh', Icons.cloud_download, 0xFFFF6699,
                        downloadRoute),
                  ],
                ),
              )
              : Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(false, 'Statistik', Icons.assessment, 0xFFC54C82,
                        statistikRoute),
                    CustomButton(false, 'Data Individu', Icons.assignment_ind,
                        0xFF512E67, dataRoute),
                    CustomButton(false, 'Unduh', Icons.cloud_download, 0xFFFF6699,
                        downloadRoute),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget customPlacement(bool p, String text, IconData icon) {
  if (p == true) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          icon,
          size: 60.0,
          color: Colors.white,
        ),
        Text(
          '$text',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.0,
          ),
        ),
      ],
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        icon,
        size: 60.0,
        color: Colors.white,
      ),
      Padding(
        padding: EdgeInsets.all(4.0),
      ),
      Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32.0,
        ),
      ),
    ],
  );
}

Widget customContainer(bool p, Widget button) {
  if (p == true) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: button,
    );
  }
  return Container(
    margin: EdgeInsets.all(5.0),
    child: button,
  );
}

class CustomButton extends StatelessWidget {
  final bool p;
  final int hexVal;
  final String text;
  final IconData icon;
  final MaterialPageRoute route;

  CustomButton(this.p, this.text, this.icon, this.hexVal, this.route);

  @override
  Widget build(BuildContext context) {
    return customContainer(
      p,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(35.0),
        color: Color(this.hexVal),
        child: customPlacement(this.p, this.text, this.icon),
        onPressed: () {
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}