

import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class RowUpdateInfo extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  const RowUpdateInfo({
    Key key,
    this.hint,
    this.label,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: height16, bottom: height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          border: Border.all(color: Colors.orange),
          color: Colors.white),
      child: TextField(
        maxLines: null,
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width6, vertical: height6),
            border: InputBorder.none,
            hintText: hint,
            labelText: label),
      ),
    );
  }
}

class SignUpDetailsTextFields extends StatelessWidget {
   final String hint;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  const SignUpDetailsTextFields({
    Key key, this.hint, this.label, this.icon, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height8),
      padding: EdgeInsets.symmetric(
          vertical: height6, horizontal: width10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          color: Colors.white70),
      child: Row(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Icon(
                icon,
                color: Colors.black,
              )),
          Flexible(
              flex: 12,
              child: TextField(
                maxLines: null,
                controller: controller,
                textInputAction: TextInputAction.done ,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: width6),
                    hintText: hint,
                    labelText: label),
              )),
        ],
      ),
    );
  }
}