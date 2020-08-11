import 'package:cloud_firestore/cloud_firestore.dart';
import 'products.dart';

class OrderList {
  final List<Order> order;

  OrderList(this.order);

  factory OrderList.fromJson(List<dynamic> snapshot) {
    List<Order> order = List<Order>();
    order = snapshot.map((e) => Order.fromJson(e)).toList();
    return OrderList(order);
  }
}

class Order {
  String documentId;
  String userId;
  double totalMrp;
  double priceToBePaid;
  double discount;
  bool delivered;
  bool cancel;
  int milliSecondsFromEpoch;
  DateTime dateTime;
  List<dynamic> order;

  Order(
      {this.userId,
      this.totalMrp,
      this.priceToBePaid,
      this.discount,
      this.order,
      this.cancel,
      this.delivered,
      this.milliSecondsFromEpoch,this.documentId});

  Order.fromJson(DocumentSnapshot json) {
    userId = json['userId'];
    totalMrp = json['totalMrp'];
    priceToBePaid = json['priceToBePaid'];
    discount = json['discount'];
    order = json['order'] ;
    delivered = json['delivered'];
    cancel = json['cancel'];
    milliSecondsFromEpoch = json['milli'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(milliSecondsFromEpoch);
    documentId = json.documentID;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['totalMrp'] = this.totalMrp;
    data['priceToBePaid'] = this.priceToBePaid;
    data['discount'] = this.discount;
    data['order'] = this.order;
    data['delivered'] = this.delivered;
    data['cancel'] = this.cancel;
    data['milli'] = this.milliSecondsFromEpoch;
    return data;
  }

  List<Map<String, dynamic>> convertToOrder(List<Product> product) {
    final List<Map<String, dynamic>> order = List<Map<String, dynamic>>();
    product.forEach((element) {
      print(element.name);
      print(element.quantityOrdered);
      order.add({
        "name": element.name,
         "qty": element.quantityOrdered,
         "price" : element.price
      });
    });
    return order;
  }
}
