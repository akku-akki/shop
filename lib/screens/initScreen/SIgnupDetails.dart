import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/screens/globalWidgets/Buttons.dart';
import 'package:shop/screens/globalWidgets/backgroundImage.dart';
import 'package:shop/screens/globalWidgets/textFieldBuilders.dart';

class SignupDetails extends StatelessWidget {


 TextEditingController _name =TextEditingController();
  TextEditingController _email =TextEditingController();
 TextEditingController _phone =TextEditingController();
 TextEditingController _address =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(child: BackGroundImage()),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: width8,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: height150,
                ),
                SignUpDetailsTextFields(
                  controller: _name,
                  label: "Name",
                  hint: "Name",
                  icon: LineIcons.user,
                ),
                SignUpDetailsTextFields(
                  controller: _email,
                  label: "Email",
                  hint: "Email",
                  icon: LineIcons.envelope_o,
                ),
                SignUpDetailsTextFields(
                  controller: _phone,
                  label: "Phone",
                  hint: "Phone",
                  icon: LineIcons.phone,
                ),
                SignUpDetailsTextFields(
                  controller: _address,
                  label: "Delivery Address",
                  hint: "Delivery Address",
                  icon: LineIcons.home,
                ),
                SizedBox(
                  height: height16,
                ),
                RaisedButton(
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
       print(_name.text);
       print(_email.text);
       print(_phone.text);
       print(_address.text);
        })
              ],
            ),
          )
        ],
      ),
    );
  }
}
