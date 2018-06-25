import './homeScreen.dart';
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
  Item item;
  List<Item> items = List();
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
    final TextStyle textStyle = Theme.of(context).textTheme.button;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Miriad-Pro', accentColor: Color(0xFFC54C82)),
      home: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFFC54C82),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text(
            'Jaga Sehat',
            style: TextStyle(
              color: Color(0xFFC54C82),
              fontSize: 26.0,
              fontFamily: 'Kelvetica',
            ),
          ),
          actions: <Widget>[
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
                    dataNum++;
                    return Card(
                      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0,),
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
                                    color: Color(0xFFC54C82),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.email,
                                    color: Color(0xFFC54C82),
                                  ),
                                  title: Text(
                                    'Email',
                                    style: TextStyle(
                                      color: Color(0xFFC54C82),
                                    ),
                                  ),
                                  subtitle: Text('$email'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Color(0xFFC54C82),
                                  ),
                                  title: Text(
                                    'Jenis Kelamin',
                                    style: TextStyle(
                                      color: Color(0xFFC54C82),
                                    ),
                                  ),
                                  subtitle: Text('$jk'),
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Color(0xFFC54C82),
                                margin: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.work,
                                    color: Color(0xFFC54C82),
                                  ),
                                  title: Text(
                                    'Pekerjaan',
                                    style: TextStyle(
                                      color: Color(0xFFC54C82),
                                    ),
                                  ),
                                  subtitle: Text('$pekerjaan'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFFC54C82),
                                  ),
                                  title: Text(
                                    'Usia',
                                    style: TextStyle(
                                      color: Color(0xFFC54C82),
                                    ),
                                  ),
                                  subtitle: Text('$usia'),
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Color(0xFFC54C82),
                                margin: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.import_contacts,
                                    color: Color(0xFFC54C82),
                                  ),
                                  title: Text(
                                    'Tingkat Pendidikan',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFFC54C82),
                                    ),
                                  ),
                                  subtitle: Text('$pendidikan'),
                                ),
                              ),
                            ],
                          ),
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

class Item {
  String key, jk, usia, pendidikan, pekerjaan, email;

  Item(this.jk, this.usia, this.pendidikan, this.pekerjaan, this.email);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        jk = snapshot.value["jk"],
        usia = snapshot.value["usia"],
        pendidikan = snapshot.value["pendidikan"],
        pekerjaan = snapshot.value["pekerjaan"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "jk": jk,
      "usia": usia,
      "pendidikan": pendidikan,
      "pekerjaan": pekerjaan,
      "email": email,
    };
  }
}
