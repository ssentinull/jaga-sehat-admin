import './auth.dart';
import './dataScreen.dart';
import './statisticsScreen.dart';
import './backgrounds.dart';
import './reusableWidgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  static var httpClient = new HttpClient();

  HomeScreen({this.auth, this.onSignedOut});

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print('Error: $e');
    }
  }

_launchUrl(String uri) async {
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

  @override
  Widget build(BuildContext context) {
    String url =
"jagasehat-c7c2e.firebaseio.com/.json?print=pretty&format=export&download=jagasehat-c7c2e-export.json&auth=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1MzA4ODIxMDksImV4cCI6MTUzMDg4NTcwOSwidiI6MCwiYWRtaW4iOnRydWV9.oiyOQuGTVN71DvOTLKGc40LQgRytcejIrQWIF_6RV-A";

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

    var statistikButton1 = customContainer(
      true,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFFC54C82),
        child: customPlacement(true, 'Statistik', Icons.assessment),
        onPressed: () {
          Navigator.of(context).push(statistikRoute);
        },
      ),
    );

    var dataButton1 = customContainer(
      true,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFF512E67),
        child: customPlacement(true, 'Data Individu', Icons.assignment_ind),
        onPressed: () {
          Navigator.of(context).push(dataRoute);
        },
      ),
    );

    var unduhButton1 = customContainer(
      true,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFFFF6699),
        child: customPlacement(true, 'Unduh Data', Icons.cloud_download),
        onPressed: () {
          _launchUrl('http:$url');
        },
      ),
    );

    var statistikButton2 = customContainer(
      false,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFFC54C82),
        child: customPlacement(false, 'Statistik', Icons.assessment),
        onPressed: () {
          Navigator.of(context).push(statistikRoute);
        },
      ),
    );

    var dataButton2 = customContainer(
      false,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFF512E67),
        child: customPlacement(false, 'Data Individu', Icons.assignment_ind),
        onPressed: () {
          Navigator.of(context).push(dataRoute);
        },
      ),
    );

    var unduhButton2 = customContainer(
      false,
      RaisedButton(
        elevation: 1.5,
        padding: EdgeInsets.all(40.0),
        color: Color(0xFFFF6699),
        child: customPlacement(false, 'Unduh Data', Icons.cloud_download),
        onPressed: () {
          _launchUrl('https:$url');
        },
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
      ),
      home: Scaffold(
        appBar: CustomAppBar2(
          logoutButton: logoutButtons,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              child: HomeScreenOverlay(
                  Color(0xFFC54C82), Color(0xFF512E67), Color(0xFFFF6699)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return Center(
                  child: orientation == Orientation.portrait
                      ? Container(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              statistikButton1,
                              dataButton1,
                              unduhButton1
                            ],
                          ),
                        )
                      : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              statistikButton2,
                              dataButton2,
                              unduhButton2
                            ],
                          ),
                        ),
                );
              },
            ),
          ],
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
          fontSize: 26.0,
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
