import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/login.dart';
import 'package:shop/firebaseRepo/loginRepo.dart';
import 'package:shop/screens/globalWidgets/commonDialog.dart';
import 'package:shop/screens/initScreen/shop.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  LoginRepo _login = LoginRepo();

  TextEditingController controller = TextEditingController();

  AnimationController animationcontroller;
  FlutterToast toast;
  // bool isPlaying = false;

  String get timerString {
    Duration duration =
        animationcontroller.duration * animationcontroller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 120),
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context,false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/ic_launcher.png",fit: BoxFit.contain,width: ref.widthFactor*120,height: ref.heightFactor*110,),

                RichText(
                  text: TextSpan(
                    text: ConstNames.enterOTPsent,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: ref.widthFactor * 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '+919999999999',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: ConstNames.comfortaa,
                              fontStyle: FontStyle.italic,
                              color: Colors.orange,
                              fontSize: ref.widthFactor * 17)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width10),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: TextField(
                    controller: controller,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontFamily: ConstNames.comfortaa,
                        fontSize: ref.widthFactor * 18,
                        letterSpacing: ref.widthFactor * 8),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: width30),
                    ),
                  ),
                ),
                AnimatedBuilder(
                    animation: animationcontroller,
                    builder: (BuildContext context, _) {
                      return Text(timerString);
                    }),
                RaisedButton(
                  padding: EdgeInsets.all(height16),
                  shape:
                      StadiumBorder(side: BorderSide(color: Colors.grey[800])),
                  onPressed: () async {
                    bool result = await _login.signInWithOTP(
                        controller.text, loginBloc.verificationId);
                    if (result) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Shop()));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.orange,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }
}
