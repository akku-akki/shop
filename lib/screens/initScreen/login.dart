import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/custom_size.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/homeBloc.dart';
import 'package:shop/bloc/login.dart';
import 'package:shop/offline/connectivity.dart';
import 'package:shop/screens/globalWidgets/Buttons.dart';
import 'package:shop/screens/globalWidgets/backgroundImage.dart';
import 'package:shop/screens/globalWidgets/commonDialog.dart';
import 'package:shop/screens/globalWidgets/noDataWidget.dart';
import 'package:shop/screens/initScreen/shop.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  LoginBloc bloc = LoginBloc();
  final TextEditingController _controller = TextEditingController(text: "+91");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = CustomSize.customSize;
    final loginBloc = Provider.of<LoginBloc>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<bool>(
            future: CheckConnectivity.checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.data == false) return NoInternet();
              return Stack(
                children: <Widget>[
                  BackGroundImage(),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Spacer(),
                        Image.asset("assets/ic_launcher.png",fit: BoxFit.contain,width: ref.widthFactor*120,height: ref.heightFactor*110,),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ref.widthFactor * 50,
                              bottom: ref.widthFactor * 8),
                          child: Text(
                            "Happy Shoping",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ref.widthFactor * 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width8),
                            color: Colors.white70,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: width8, vertical: height6),
                          child: TextField(
                            style: TextStyle(
                                fontFamily: ConstNames.comfortaa,
                                color: Colors.black),
                            controller: _controller,
                            autocorrect: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                labelText: "Mobile No.",
                                contentPadding: EdgeInsets.only(left: width8),
                                border: InputBorder.none,
                                hintText: "+91900000000",
                                labelStyle: TextStyle(color: Colors.black)),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(
                          height: height16,
                        ),
                        ContinueButton(
                          onTap: () async {
                            loginBloc.setPhoneNo(_controller.text);
                            await loginBloc.signUp(context);
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ref.heightFactor * 25,
                                bottom: ref.heightFactor * 25),
                            child: Text(
                              "OR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ref.widthFactor * 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        RaisedButton(
                            padding: EdgeInsets.all(height16),
                            color: Colors.blue,
                            shape: StadiumBorder(
                                side: BorderSide(color: Colors.grey[800])),
                            child: Text(
                              "Sign In with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            onPressed: ()  {
                            loginBloc.signInWithGoogle(context);
                              // if (result) {
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Shop()));
                              // } else {
                              //   commonDialog(context, "! OOPS",
                              //       "!! Unable To Connect try Later");
                              // }
                            }),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
