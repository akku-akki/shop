import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class ToastWidget extends StatelessWidget {
  final String text;
  final Color c;
  const ToastWidget({
    Key key,
    this.text,
    this.c,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: c,
      child: Padding(
        padding: EdgeInsets.all(width16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}