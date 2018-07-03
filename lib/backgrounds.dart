import 'package:flutter/material.dart';
import 'dart:math';

Widget _centerCircle(double radius, double opacity, Color color) {
  return Positioned(
    width: radius,
    child: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
    ),
  );
}

Widget _largeCircle(Size size, Color color, double numOp) {
  Random rnd = Random();
  double top = rnd.nextDouble();
  double radius = rnd.nextDouble() * size.height;
  double opacity = rnd.nextDouble() * numOp;

  return Positioned(
    top: top,
    width: radius,
    child: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
    ),
  );
}

Widget _smallShape(Size size, Color color, BoxShape shape) {
  Random rnd = Random();
  double top = rnd.nextDouble() * size.height;
  double left = rnd.nextDouble() * size.width;
  double radius = rnd.nextDouble() * 20.0;
  double opacity = rnd.nextDouble() * 0.75;

  return Positioned(
    top: top,
    left: left,
    width: radius,
    child: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: shape,
        color: color.withOpacity(opacity),
      ),
    ),
  );
}

class SplashOverlay extends StatelessWidget {
  final Color color;

  SplashOverlay(this.color);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Widget> widgets = [];
    List<Widget> smallCircles =
        List(10).map((_) => _smallShape(MediaQuery.of(context).size, this.color, BoxShape.circle)).toList();
    List<Widget> centerCircles = [
      _centerCircle(width * 1.35, 0.07, this.color),
      _centerCircle(width * 1.25, 0.1, this.color),
      _centerCircle(width * 1.0, 0.15, this.color),
      _centerCircle(width * 0.40, 0.5, this.color),
    ];
    widgets.addAll(smallCircles);
    widgets.addAll(centerCircles);

    return Stack(
      children: widgets,
      alignment: FractionalOffset.center,
    );
  }
}

class HomeScreenOverlay extends StatelessWidget {
  final Color color1, color2, color3;

  HomeScreenOverlay(this.color1, this.color2, this.color3);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    List<Widget> square1 =
        List(55).map((_) => _smallShape(MediaQuery.of(context).size, this.color1, BoxShape.rectangle)).toList();
    List<Widget> square2 =
        List(55).map((_) => _smallShape(MediaQuery.of(context).size, this.color2, BoxShape.rectangle)).toList();
    List<Widget> square3 =
        List(55).map((_) => _smallShape(MediaQuery.of(context).size, this.color3, BoxShape.rectangle)).toList();
    
    widgets.addAll(square1);
    widgets.addAll(square2);
    widgets.addAll(square3);

    return Stack(
      children: widgets,
      alignment: FractionalOffset.center,
    );
  }
}

class SingleColorOverlay extends StatelessWidget {
  final Color color;

  SingleColorOverlay(this.color);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    List<Widget> square1 =
        List(100).map((_) => _smallShape(MediaQuery.of(context).size, this.color, BoxShape.circle)).toList();
    
    widgets.addAll(square1);

    return Stack(
      children: widgets,
      alignment: FractionalOffset.center,
    );
  }
}
