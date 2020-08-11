import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/model/homeProducts.dart';
import 'package:shop/model/products.dart';
import 'package:shop/model/faliure.dart';

class HomeRepo {
  final firebase = Firestore.instance;

  Future<DisplayList> getHomeDisplayProducts() async {
    print("display Executed");
    DisplayList dis;
    try {
      QuerySnapshot snapshot =
          await firebase.collection("display").snapshots().first;
      dis = DisplayList.fromJson(snapshot.documents.first.data.values.first);
     
      return dis;
    } on SocketException {
      throw Faliure("No Internet");
    } on HttpException {
      throw Faliure("No Service Found");
    } on FormatException {
      throw Faliure("Invalid Data Format");
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<ProductListItems> getSingularProducts(String collection) async {
    ProductListItems productList;
    QuerySnapshot snapshot;
    try {
      print("Executing product start");
      snapshot = await firebase
          .collection("rice").getDocuments();
 
      productList = ProductListItems.fromJson(snapshot.documents );
      return productList;
    } on SocketException {
      print("No Internet");
      throw Faliure("No Internet");
    } on HttpException {
      print('No Service Found');
      throw Faliure("No Service Found");
    } on FormatException {
      print("Invalid Data Format");
      throw Faliure("Invalid Data Format");
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}


