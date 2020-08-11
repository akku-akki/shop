import 'package:vector_math/vector_math_64.dart' show Vector3;


import 'package:flutter/material.dart';


// TODO statless

class ImageZoom extends StatefulWidget {
  @override
  _ImageZoomState createState() => _ImageZoomState();
}


class _ImageZoomState extends State<ImageZoom> {
  double _scale = 2.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 300,
        child: new Transform(
          transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
          alignment: FractionalOffset.center,
          child: Image.asset(
            "assets/Rice.jpg",
            fit: BoxFit.cover,
            scale: _scale,
          ),
        ),
      ),
    );
  }

}
