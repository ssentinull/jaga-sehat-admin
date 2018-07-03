import './homeScreen.dart';
import './reusableWidgets.dart';
import './backgrounds.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int dataNum = 0;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('data_pengguna');
  }

  @override
  Widget build(BuildContext context) {
    var backButtons = IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color(0xFFC54C82),
        ),
        onPressed: () {
          Navigator.pop(context, true);
        });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Miriad-Pro',
        accentColor: Color(0xFFC54C82),
      ),
      home: Scaffold(
        appBar: CustomAppBar3(
          backButton: backButtons,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              child: SingleColorOverlay(Color(0xFF512E67)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: FirebaseAnimatedList(
                        query: itemRef,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          Map map = snapshot.value;
                          String jk = map['jk'] as String,
                              usia = map['usia'] as String,
                              pendidikan = map['pendidikan'] as String,
                              pekerjaan = map['pekerjaan'] as String,
                              email = map['email'] as String;
                          var rawDate = new DateTime.fromMicrosecondsSinceEpoch(
                              map['time_stamp'] * 1000);
                          var dateFormater = DateFormat.yMd().add_jm();
                          var date = dateFormater.format(rawDate);
                          dataNum++;
                          return Card(
                            margin: orientation == Orientation.portrait
                                ? EdgeInsets.only(
                                    left: 12.0,
                                    right: 12.0,
                                    top: 6.0,
                                    bottom: 6.0,
                                  )
                                : EdgeInsets.only(
                                    left: 100.0,
                                    right: 100.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                            child: Container(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                        ),
                                        child: Text(
                                          'Data Ke: $dataNum',
                                          style: TextStyle(
                                            fontFamily: 'Kelvetica',
                                            fontSize: 18.0,
                                            color: Color(0xFFC54C82),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            'Waktu Unggah Data',
                                            style: TextStyle(
                                              color: Color(0xFFC54C82),
                                            ),
                                          ),
                                          subtitle: Text('$date'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CustomExpandedWidget(
                                          'Jenis Kelamin', jk, Icons.person),
                                      CustomDivider(),
                                      CustomExpandedWidget(
                                          'Pekerjaan', pekerjaan, Icons.work),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CustomExpandedWidget(
                                          'Usia', usia, Icons.calendar_today),
                                      CustomDivider(),
                                      CustomExpandedWidget('Tingkat Pendidikan',
                                          pendidikan, Icons.import_contacts),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CustomExpandedWidget(
                                          'Email', email, Icons.email),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpandedWidget extends StatelessWidget {
  final String category, data;
  final IconData icon;

  CustomExpandedWidget(this.category, this.data, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: Color(0xFFC54C82),
        ),
        title: Text(
          '$category',
          style: TextStyle(
            color: Color(0xFFC54C82),
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          '$data',
          style: TextStyle(fontSize: 13.0),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 1.0,
      color: Color(0xFFC54C82),
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
    );
  }
}
