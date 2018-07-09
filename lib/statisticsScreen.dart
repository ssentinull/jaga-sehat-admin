import './homeScreen.dart';
import './backgrounds.dart';
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
  int jmlPria = 0,
      jmlWanita = 0,
      jml617 = 0,
      jml1829 = 0,
      jml3045 = 0,
      jml4660 = 0,
      jml60 = 0,
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
      totalUsia = 0,
      totalPen = 0,
      totalPek = 0;
  String bnkyJk, bnkyUsia, bnkyPen, bnkyPek;
  Color colorPrimary, colorSecondary, colorTertiary;
  DatabaseReference dbReference;

  String countBnyk(List<Banyak> list) {
    int tmpJml = 0;
    String tmpKat;
    for (var i = 0; i < list.length; i++) {
      if (list[i].jml > tmpJml) {
        tmpJml = list[i].jml;
        tmpKat = list[i].kategori;
      }
    }
    return tmpKat;
  }

  @override
  void initState() {
    super.initState();

    dbReference = FirebaseDatabase.instance.reference().child("data_pengguna");

    dbReference.orderByChild("jk").equalTo("Pria").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPria = data.length;
      });
    });

    dbReference.orderByChild("jk").equalTo("Wanita").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlWanita = data.length;
      });
    });

    dbReference.orderByChild("usia").equalTo("6 - 17").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jml617 = data.length;
      });
    });

    dbReference.orderByChild("usia").equalTo("18 - 29").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jml1829 = data.length;
      });
    });

    dbReference.orderByChild("usia").equalTo("30 - 45").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jml3045 = data.length;
      });
    });

    dbReference.orderByChild("usia").equalTo("46 - 60").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jml4660 = data.length;
      });
    });

    dbReference.orderByChild("usia").equalTo("60+").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jml60 = data.length;
      });
    });

    dbReference.orderByChild("pendidikan").equalTo("SD").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSd = data.length;
      });
    });

    dbReference.orderByChild("pendidikan").equalTo("SMP").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSmp = data.length;
      });
    });

    dbReference.orderByChild("pendidikan").equalTo("SMA").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSma = data.length;
      });
    });

    dbReference
        .orderByChild("pendidikan")
        .equalTo("Perguruan Tinggi")
        .once()
        .then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPt = data.length;
      });
    });

    dbReference.orderByChild("pekerjaan").equalTo("PNS").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPns = data.length;
      });
    });

    dbReference
        .orderByChild("pekerjaan")
        .equalTo("Pegawai Swasta")
        .once()
        .then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlSwas = data.length;
      });
    });

    dbReference
        .orderByChild("pekerjaan")
        .equalTo("Wiraswasta")
        .once()
        .then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlWrs = data.length;
      });
    });

    dbReference.orderByChild("pekerjaan").equalTo("Mahasiswa").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlMhs = data.length;
      });
    });

    dbReference.orderByChild("pekerjaan").equalTo("Pelajar").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlPlj = data.length;
      });
    });

    dbReference.orderByChild("pekerjaan").equalTo("Lainnya").once().then((onValue) {
      Map data = onValue.value;
      setState(() {
        jmlLnn = data.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    totalJk = jmlPria + jmlWanita;
    totalUsia = jml617 + jml1829 + jml3045 + jml4660 + jml60;
    totalPen = jmlSd + jmlSmp + jmlSma + jmlPt;
    totalPek = jmlPns + jmlSwas + jmlWrs + jmlMhs + jmlPlj + jmlLnn;

    List<Banyak> arrayJk = [
      Banyak(jmlPria, 'Pria'),
      Banyak(jmlWanita, 'Wanita')
    ];

    List<Banyak> arrayUsia = [
      Banyak(jml617, '6 - 17'),
      Banyak(jml1829, '18 - 29'),
      Banyak(jml3045, '30 - 45'),
      Banyak(jml4660, '46 - 60'),
      Banyak(jml60, '60+')
    ];

    List<Banyak> arrayPen = [
      Banyak(jmlSd, 'SD'),
      Banyak(jmlSmp, 'SMP'),
      Banyak(jmlSma, 'SMP'),
      Banyak(jmlPt, 'PT')
    ];

    List<Banyak> arrayPek = [
      Banyak(jmlPns, 'PNS'),
      Banyak(jmlSwas, 'Swasta'),
      Banyak(jmlWrs, 'Wiraswasta'),
      Banyak(jmlMhs, 'Mahasiswa'),
      Banyak(jmlPlj, 'Pelajar'),
      Banyak(jmlLnn, 'Lainnya')
    ];

    setState(() {
      bnkyJk = countBnyk(arrayJk);
      bnkyUsia = countBnyk(arrayUsia);
      bnkyPen = countBnyk(arrayPen);
      bnkyPek = countBnyk(arrayPek);
    });

    var statJk = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomContainer('Pria', Color(0xFFC54C82), jmlPria),
        CustomContainer('Wanita', Color(0xFFFF6699), jmlWanita),
        CustomContainer('Total', Color(0xFF512E67), totalJk),
      ],
    );

    var statUsia = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomContainer('6 - 17', Color(0xFFC54C82), jml617),
            CustomContainer('18 - 29', Color(0xFFFF6699), jml1829),
            CustomContainer('30 - 45', Color(0xFF512E67), jml3045),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomContainer('46 - 60', Color(0xFFC54C90), jml4660),
            CustomContainer('60+', Color(0xFF512E67), jml60),
            CustomContainer('Total', Color(0xFF512E80), totalUsia),
          ],
        ),
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

    var dataUsia = [
      Demografi('6 - 17', jmlPns, Color(0xFFC54C82)),
      Demografi('18 - 29', jmlSwas, Color(0xFFFF6699)),
      Demografi('30 - 45', jmlWrs, Color(0xFF512E67)),
      Demografi('46 - 60', jmlMhs, Color(0xFF843156)),
      Demografi('60+', jmlPlj, Color(0xFF992365)),
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

    var seriesUsia = [
      charts.Series(
        id: 'Usia',
        data: dataUsia,
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

    var chartUsia = charts.BarChart<Demografi>(
      seriesUsia,
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
        appBar: CustomAppBar3(
          backButton: backButtons,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              child: SingleColorOverlay(Color(0xFFC54C82)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return Container(
                  margin: orientation == Orientation.portrait
                      ? EdgeInsets.only(left: 8.0, right: 8.0)
                      : EdgeInsets.only(left: 128.0, right: 128.0),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        CustomCard(bnkyJk, bnkyUsia, bnkyPen, bnkyPek),
                        CustomChart('Jenis Kelamin', statJk, chartJk),
                        CustomChart('Usia', statUsia, chartUsia),
                        CustomChart('Pendidikan', statPen, chartPendidikan),
                        CustomChart('Pekerjaan', statPek, chartPekerjaan),
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

class CustomText extends StatelessWidget {
  final double fontSize;
  final String data;
  final Color color;

  CustomText(this.data, this.fontSize, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String jk, usia, pen, pek;

  CustomCard(this.jk, this.usia, this.pen, this.pek);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CustomText(
                'Kategori Pengguna Terbanyak',
                20.0,
                Color(0xFFC54C82),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CustomText('Jenis Kelamin : $jk', 14.0, Color(0xFF512E67)),
                    CustomText('Usia : $usia', 14.0, Color(0xFF512E67)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CustomText(
                      'Tingkat Pendidikan : $pen', 14.0, Color(0xFF512E67)),
                  CustomText('Pekerjaan : $pek', 14.0, Color(0xFF512E67)),
                ],
              ),
            ],
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
      child: CustomText(
        '$category: $data',
        16.0,
        this.color,
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
    return Container(
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              CustomText(this.title, 24.0, Color(0xFFC54C82)),
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

class Banyak {
  final int jml;
  final String kategori;

  Banyak(this.jml, this.kategori);
}
