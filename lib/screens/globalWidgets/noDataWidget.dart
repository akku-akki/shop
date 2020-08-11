import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.signal_wifi_off,size: height150,color: Colors.orange,),
          Text("No Internet")
        ],
      ),),
    );
  }
}