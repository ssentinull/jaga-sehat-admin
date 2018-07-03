import './homeScreen.dart';
import './reusableWidgets.dart';
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
        body: Container(
          color: Color(0xFF512E67),
          child: Column(
            children: <Widget>[
              Flexible(
                child: FirebaseAnimatedList(
                  query: itemRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
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
                      margin: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 4.0,
                        bottom: 4.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
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
                                CustomExpandedWidget('Jenis Kelamin', jk, Icons.person),
                                CustomDivider(),
                                CustomExpandedWidget('Pekerjaan', pekerjaan, Icons.work),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CustomExpandedWidget('Usia', usia, Icons.calendar_today),
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
          ),
        ),
      ),
    );
  }
}

class CustomExpandedWidget extends StatelessWidget {
  String category, data;
  IconData icon;

  CustomExpandedWidget(this.category, this.data, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
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
        subtitle: Text('$data'),
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
