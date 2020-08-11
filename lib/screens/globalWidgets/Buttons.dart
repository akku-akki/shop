import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.all(height16),
        shape: StadiumBorder(),
        color: Colors.orange,
        child: Text(
          "Update",
          style: TextStyle(
              fontFamily: "Comfortaa",
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
       
        });
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onTap;
  const ContinueButton({
    Key key, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(height16),
      shape: StadiumBorder(
          side: BorderSide(color: Colors.grey[800])),
      onPressed: onTap,
      color: Colors.orange,
      child: Text(
        "Continue",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "COmfortaa",
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2),
      ),
    );
  }
}