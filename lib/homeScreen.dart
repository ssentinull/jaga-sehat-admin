import './auth.dart';
import './dataScreen.dart';
import './statisticsScreen.dart';
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
    final TextStyle textStyle = Theme.of(context).textTheme.button;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            'jaga sehat',
            style: TextStyle(
                color: Color(0xFFC54C82),
                fontSize: 26.0,
                fontFamily: 'Kelvetica'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Color(0xFFC54C82),
              ),
              onPressed: _signOut,
            ),
            GestureDetector(
              child: Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/logo/logo3.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
              onTap: () => devsDialog(context),
            ),
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: RaisedButton(
                    elevation: 2.0,
                    padding: EdgeInsets.all(40.0),
                    color: Color(0xFFC54C82),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.assessment,
                          size: 60.0,
                          color: Colors.white,
                        ),
                        Text(
                          'Statistika',
                          style: TextStyle(color: Colors.white, fontSize: 36.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      var routes = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              StatisticsScreen());
                      Navigator.of(context).push(routes);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: RaisedButton(
                    elevation: 2.0,
                    padding: EdgeInsets.all(40.0),
                    color: Color(0xFF512E67),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.assignment_ind,
                          size: 60.0,
                          color: Colors.white,
                        ),
                        Text(
                          'Data Individu',
                          style: TextStyle(color: Colors.white, fontSize: 32.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      var routes = MaterialPageRoute(
                          builder: (BuildContext context) => DataScreen());
                      Navigator.of(context).push(routes);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

devsDialog(BuildContext context) {
  showDialog(
    context: context,
    child: Center(
      child: Container(
        width: 320.0,
        height: 280.0,
        child: Card(
          elevation: 0.5,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Pengembang Aplikasi',
                    style: TextStyle(
                      color: Color(0xFFC54C82),
                      fontSize: 24.0,
                    ),
                  ),
                ),
                NameWidget(
                    'assets/photo/20.jpg', '140810160020', 'Hasna Karimah'),
                NameWidget(
                    'assets/photo/42.jpg', '140810160042', 'Aditya Rizky F.'),
                NameWidget(
                    'assets/photo/54.jpg', '140810160054', 'Ibnu Ahsani'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class NameWidget extends StatelessWidget {
  String _npm, _name, _assetPath;

  NameWidget(this._assetPath, this._npm, this._name);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50.0,
          height: 50.0,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('$_assetPath'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
        ),
        Container(
          height: 40.0,
          width: 1.0,
          color: Color(0xFFC54C82),
          margin: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$_npm',
              style: TextStyle(color: Color(0xFFC54C82), fontSize: 20.0),
            ),
            Text(
              '$_name',
              style: TextStyle(color: Color(0xFF512E67), fontSize: 18.0),
            ),
          ],
        ),
      ],
    );
  }
}
