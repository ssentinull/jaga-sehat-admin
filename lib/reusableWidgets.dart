import 'package:flutter/material.dart';

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

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'jaga sehat',
      style: TextStyle(
        color: Color(0xFFC54C82),
        fontSize: 26.0,
        fontFamily: 'Kelvetica',
      ),
    );
  }
}

class LogoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class CustomAppBar1 extends AppBar {
  CustomAppBar1()
      : super(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: AppBarTitle(),
        );
}

class CustomAppBar2 extends AppBar {
  CustomAppBar2({IconButton logoutButton})
      : super(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: AppBarTitle(),
          actions: <Widget>[
            logoutButton,
            LogoButton(),
          ],
        );
}

class CustomAppBar3 extends AppBar {
  CustomAppBar3({IconButton backButton})
      : super(
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: backButton,
          title: AppBarTitle(),
          actions: <Widget>[
            LogoButton(),
          ],
        );
}
