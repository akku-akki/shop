import 'package:shared_preferences/shared_preferences.dart';
import '../ScreenUtils/staticNames.dart';

class OfflineDetails {
  static void setUserStatus(bool status) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(ConstNames.logged_In_Status, status);
  }

  static void setUserDetails(
      {String name, String email, String phone, String add,bool val}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(ConstNames.userName, name);
    prefs.setString(ConstNames.userEmail, email);
    prefs.setString(ConstNames.userPhone, phone);
    prefs.setString(ConstNames.userAddress, add);
    prefs.setBool(ConstNames.hasUserData, val);
  }

  static Future<String> getName() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(ConstNames.userName);
  }

  static Future<String> getEmail() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(ConstNames.userEmail);
  }

  static Future<String> getPhone() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(ConstNames.userPhone);
  }

  static Future<String> getAddress() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(ConstNames.userAddress);
  }

  static Future<bool> hasUserDetails() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(ConstNames.hasUserData);
  }

  static Future<bool> checkUserStatus() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(ConstNames.logged_In_Status) ?? false;
  }

  static void setUserId(String id) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(ConstNames.userId, id);
  }

  static Future<String> getUserId() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(ConstNames.userId);
  }
}
