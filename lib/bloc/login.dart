import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop/bloc/homeBloc.dart';
import 'package:shop/screens/globalWidgets/commonDialog.dart';
import 'package:shop/screens/initScreen/otpScreen.dart';
import 'package:shop/screens/initScreen/shop.dart';
import '../firebaseRepo/loginRepo.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc {
  LoginRepo _loginRepo = LoginRepo();
  HomeBloc homeBloc;
  // PipeControllers
  final _loading = BehaviorSubject.seeded(false);
  final _phoneNo = BehaviorSubject<String>.seeded("");
  final _verificationId = PublishSubject();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Streams and Sinks
  Stream<String> get verificationId => _verificationId.stream;
  Function get setVerificationId => _verificationId.sink.add;

  Stream<bool> get loading => _loading.stream;
  Function get setLoadingStatus => _loading.sink.add;

  Stream<String> get phoneNo => _phoneNo.stream;
  Function get setPhoneNo => _phoneNo.sink.add;

  signUp(BuildContext context) async {
    if (await OfflineDetails.checkUserStatus()) {
      homeBloc.loadHomeItems();
      return true;
    } else {
      try {
        await verifyPhone(_phoneNo.value, context);
      } catch (e) {
        commonDialog(context, "Verification Failed", "Try Again Later!");
      }
    }
  }

  // void resendVerificationCode(
  //   String phoneNumber,
  // ) {}

  signInWithGoogle(BuildContext context) async {
    if (await OfflineDetails.checkUserStatus()) {
      homeBloc.loadHomeItems();
      return true;
    } else {
      try {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        AuthResult auth = await _loginRepo.signIn(credential);
        if (auth != null) {
          OfflineDetails.setUserId(auth.user.uid);
          OfflineDetails.setUserStatus(true);
          homeBloc.loadHomeItems();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Shop()));
        } else {
          commonDialog(context, "! OOPS", "!! Unable To Connect try Later");
        }
      } catch (e) {
        commonDialog(context, "! OOPS", "!! Unable To Connect try Later");
      }
    }
  }

  verifyPhone(String phoneNo, BuildContext context) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      AuthResult auth = await _loginRepo.signIn(authResult);
      if (auth != null) {
        OfflineDetails.setUserId(auth.user.uid);
        OfflineDetails.setUserStatus(true);
        homeBloc.loadHomeItems();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Shop()));
      } else {
        commonDialog(context, "! OOPS", "!! Unable To Connect try Later");
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      Navigator.pop(context);
      commonDialog(context, "Verification Failed", "Provide a valid data");
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async {
      setVerificationId(verId);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpScreen()));
      // if (result) {
      //   return true;
      // } else {
      //   commonDialog(context, "Session Expired", "Press continue to try again");
      //   return false;
      // }
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      setVerificationId(verId);
      // return false
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeOut,
    );
  }

  dispose() {
    _loading.close();
    _phoneNo.close();
    _verificationId.close();
  }
}
