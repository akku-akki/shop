import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/model/faliure.dart';

class ProfileCat {
  final firebase = Firestore.instance;

  Future<bool> setProfile(String name, String phone, String address,
      String email, String userId) async {
    try {
      await firebase.collection('users').document(userId).setData({
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "id": userId
      }, merge: true,).timeout(Duration(seconds: 60));
      return true;
    } on SocketException {
      print("Order Failed1");
      throw Faliure("No Internet");
    } on HttpException {
      print("Order Failed2");
      throw Faliure("No Service Found");
    } on FormatException {
      print("Order Failed3");
      throw Faliure("Invalid Data Format");
    } catch (e) {
      print("Order Failed4");
      throw Faliure(e.message);
    }
  }
}
