import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/model/order.dart';
import 'package:shop/model/faliure.dart';
import 'package:shop/offline/sharedPrefs.dart';

class OrderRepo {
  final firebase = Firestore.instance;

  Future<bool> placeOrder(Order order) async {
    CollectionReference ref = Firestore.instance.collection('orders');
    try {
      await firebase.runTransaction((Transaction transaction) async {
        await transaction.set(ref.document(), order.toJson());
      });
      print("Order Placed");
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

  Future<bool> cancelOrder(String docId) async {
    try {
      await Firestore.instance
          .collection("orders")
          .document(docId)
          .updateData({"cancel": true});
      print("Order Placed");
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

  Future<OrderList> getMyOrders() async {
    OrderList orderList;
    QuerySnapshot snapshot;
    String id = await OfflineDetails.getUserId();
    try {
      print("Fetching bill");
      snapshot = await Firestore.instance
          .collection("orders")
          .where("userId", isEqualTo: id)
          .where('cancel', isEqualTo: false)
          .getDocuments();
      if (snapshot.documents.isEmpty) {
        orderList = null;
        return orderList;
      } else {
        snapshot.documents.forEach((element) {
          print(element.data);
        });
        orderList = OrderList.fromJson(snapshot.documents);
        orderList.order.forEach((element) {
          print(element.priceToBePaid);
        });
        return orderList;
      }
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
