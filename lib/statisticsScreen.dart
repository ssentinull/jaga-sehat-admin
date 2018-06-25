import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('data_pengguna');
  }

  @override
  Widget build(BuildContext context) {
    var dataJk = [
      Demografi('Pria', 12, Color(0xFFC54C82)),
      Demografi('Wanita', 42, Color(0xFFFF6699)),
    ];

    var dataPendidikan = [
      Demografi('SD', 12, Color(0xFFC54C82)),
      Demografi('SMP', 42, Color(0xFFFF6699)),
      Demografi('SMA', 22, Color(0xFF512E67)),
      Demografi('Perguruan Tinggi', 10, Color(0xFFC54C90)),
    ];

    var dataPekerjaan = [
      Demografi('PNS', 12, Color(0xFFC54C82)),
      Demografi('Swasta', 42, Color(0xFFFF6699)),
      Demografi('Wiraswasta', 22, Color(0xFF512E67)),
      Demografi('Mahasiswa', 10, Color(0xFFC54C100)),
      Demografi('Pelajar', 10, Color(0xFFFF66130)),
      Demografi('Lainnya', 10, Color(0xFF512E80)),
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

    var chartWidgetJk = ChartWidget('Jenis Kelamin', chartJk);
    var chartWidgetPendidikan = ChartWidget('Pendidikan', chartPendidikan);
    var chartWidgetPekerjaan = ChartWidget('Pekerjaan', chartPekerjaan);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Myriad-Pro',
        accentColor: Color(0xFFC54C82),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFC54C82),
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
                fontFamily: 'Kelvetica'),
          ),
          actions: <Widget>[
            Container(
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
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                chartWidgetJk,
                chartWidgetPendidikan,
                chartWidgetPekerjaan,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final String title;
  final charts.BarChart chart;

  ChartWidget(this.title, this.chart);

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
            )
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
