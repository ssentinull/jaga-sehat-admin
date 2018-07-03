import './homeScreen.dart';
import './reusableWidgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DatabaseReference hello;
  int jmlPria = 0,
      jmlWanita = 0,
      jmlSd = 0,
      jmlSmp = 0,
      jmlSma = 0,
      jmlPt = 0,
      jmlPns = 0,
      jmlSwas = 0,
      jmlWrs = 0,
      jmlMhs = 0,
      jmlPlj = 0,
      jmlLnn = 0,
      totalJk = 0,
      totalPen = 0,
      totalPek = 0;
  Color colorPrimary, colorSecondary, colorTertiary;

  @override
  void initState() {
    super.initState();

    hello = FirebaseDatabase.instance.reference().child("data_pengguna");

    hello.orderByChild("jk").equalTo("Pria").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPria = data.length;
      });
    });

    hello.orderByChild("jk").equalTo("Wanita").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlWanita = data.length;
      });
    });

    hello.orderByChild("pendidikan").equalTo("SD").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSd = data.length;
      });
    });

    hello.orderByChild("pendidikan").equalTo("SMP").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSmp = data.length;
      });
    });

    hello.orderByChild("pendidikan").equalTo("SMA").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSma = data.length;
      });
    });

    hello
        .orderByChild("pendidikan")
        .equalTo("Perguruan Tinggi")
        .once()
        .then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPt = data.length;
      });
    });

    hello.orderByChild("pekerjaan").equalTo("PNS").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPns = data.length;
      });
    });

    hello
        .orderByChild("pekerjaan")
        .equalTo("Pegawai Swasta")
        .once()
        .then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSwas = data.length;
      });
    });

    hello.orderByChild("pekerjaan").equalTo("Mahasiswa").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlMhs = data.length;
      });
    });

    hello.orderByChild("pekerjaan").equalTo("Pelajar").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPlj = data.length;
      });
    });

    hello.orderByChild("pekerjaan").equalTo("Lainnya").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlLnn = data.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    totalJk = jmlPria + jmlWanita;
    totalPen = jmlSd + jmlSmp + jmlSma + jmlPt;
    totalPek = jmlPns + jmlSwas + jmlWrs + jmlMhs + jmlPlj + jmlLnn;
    var statJk = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomContainer('Pria', Color(0xFFC54C82), jmlPria),
        CustomContainer('Wanita', Color(0xFFFF6699), jmlWanita),
        CustomContainer('Total', Color(0xFF512E67), totalJk),
      ],
    );

    var statPen = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomContainer('SD', Color(0xFFC54C82), jmlSd),
        CustomContainer('SMP', Color(0xFFFF6699), jmlSmp),
        CustomContainer('SMA', Color(0xFF512E67), jmlSma),
        CustomContainer('PT', Color(0xFFC54C90), jmlPt),
        CustomContainer('Total', Color(0xFF512E67), totalPen),
      ],
    );

    var statPek = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomContainer('PNS', Color(0xFFC54C82), jmlPns),
            CustomContainer('Swasta', Color(0xFFFF6699), jmlSwas),
            CustomContainer('Wiraswasta', Color(0xFF512E67), jmlWrs),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomContainer('Mahasiswa', Color(0xFF843156), jmlMhs),
            CustomContainer('Pelajar', Color(0xFF992365), jmlPlj),
            CustomContainer('Lainnya', Color(0xFF512E80), jmlLnn),
            CustomContainer('Total', Color(0xFF512E67), totalPek),
          ],
        ),
      ],
    );

    var dataJk = [
      Demografi('Pria', jmlPria, Color(0xFFC54C82)),
      Demografi('Wanita', jmlWanita, Color(0xFFFF6699)),
    ];

    var dataPendidikan = [
      Demografi('SD', jmlSd, Color(0xFFC54C82)),
      Demografi('SMP', jmlSmp, Color(0xFFFF6699)),
      Demografi('SMA', jmlSma, Color(0xFF512E67)),
      Demografi('PT', jmlPt, Color(0xFFC54C90)),
    ];

    var dataPekerjaan = [
      Demografi('PNS', jmlPns, Color(0xFFC54C82)),
      Demografi('Sws', jmlSwas, Color(0xFFFF6699)),
      Demografi('Wrs', jmlWrs, Color(0xFF512E67)),
      Demografi('Mhs', jmlMhs, Color(0xFF843156)),
      Demografi('Pelajar', jmlPlj, Color(0xFF992365)),
      Demografi('Lainnya', jmlLnn, Color(0xFF512E80)),
    ];

    var seriesJk = [
      charts.Series(
        id: 'Jk',
        data: dataJk,
        domainFn: (Demografi data, _) => data.demografi,
        measureFn: (Demografi data, _) => data.jumlah,
        colorFn: (Demografi data, _) => data.color,
      ),
    ];

    var seriesPendidikan = [
      charts.Series(
        id: 'Pendidikan',
        data: dataPendidikan,
        domainFn: (Demografi data, _) => data.demografi,
        measureFn: (Demografi data, _) => data.jumlah,
        colorFn: (Demografi data, _) => data.color,
      ),
    ];

    var seriesPekerjaan = [
      charts.Series(
        id: 'Pekerjaan',
        data: dataPekerjaan,
        domainFn: (Demografi data, _) => data.demografi,
        measureFn: (Demografi data, _) => data.jumlah,
        colorFn: (Demografi data, _) => data.color,
      ),
    ];

    var chartJk = charts.BarChart<Demografi>(
      seriesJk,
      animate: true,
    );

    var chartPendidikan = charts.BarChart<Demografi>(
      seriesPendidikan,
      animate: true,
    );

    var chartPekerjaan = charts.BarChart<Demografi>(
      seriesPekerjaan,
      animate: true,
    );

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
        fontFamily: 'Myriad-Pro',
        accentColor: Color(0xFFC54C82),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFC54C82),
        appBar: CustomAppBar3(
          backButton: backButtons,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                CustomChart('Jenis Kelamin', statJk, chartJk),
                CustomChart('Pendidikan', statPen, chartPendidikan),
                CustomChart('Pekerjaan', statPek, chartPekerjaan),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String category;
  final int data;
  final Color color;

  CustomContainer(this.category, this.color, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0, right: 8.0, left: 8.0),
      child: Text(
        '$category: $data',
        style: TextStyle(
          fontSize: 16.0,
          color: this.color,
        ),
      ),
    );
  }
}

class CustomChart extends StatelessWidget {
  final String title;
  final Widget data;
  final charts.BarChart chart;

  CustomChart(this.title, this.data, this.chart);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(fontSize: 24.0, color: Color(0xFFC54C82)),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                height: 200.0,
                child: this.chart,
              ),
            ),
            Container(
              child: this.data,
            ),
          ],
        ),
      ),
    );
  }
}

class Demografi {
  final String demografi;
  final int jumlah;
  final charts.Color color;

  Demografi(this.demografi, this.jumlah, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
