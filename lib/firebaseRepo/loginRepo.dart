import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/offline/sharedPrefs.dart';

class LoginRepo {
  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      OfflineDetails.setUserDetails(
          add: "", email: "", name: "", phone: "", val: false);
      OfflineDetails.setUserStatus(false);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AuthResult> signIn(AuthCredential authCreds) async {
    try {
      AuthResult res =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
    
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signInWithOTP(smsCode, verId) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.getCredential(
          verificationId: verId, smsCode: smsCode);
      await signIn(authCredential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
