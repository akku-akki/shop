import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/model/products.dart';
import 'package:shop/model/faliure.dart';

class SearchRepo {
  final firebase = Firestore.instance;
  Future<ProductListItems> searchProducts(
      String collection, String search) async {
    String val = search.trim().toLowerCase();
    print("getting exe");
    ProductListItems productList;
    QuerySnapshot snapshot;
    try {
      print("Executing product start");
      snapshot = await firebase
          .collection("rice")
          .where("search", arrayContains: val)
          .getDocuments();
      productList = ProductListItems.fromJson(snapshot.documents);
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
