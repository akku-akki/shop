import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListItems {
  final List<Product> productList;
  ProductListItems(this.productList);
  factory ProductListItems.fromJson(List<DocumentSnapshot> snapshot) {
    List<Product> products = List<Product>();
    products = snapshot.map((e) => Product.fromJson(e)).toList();
    return ProductListItems(products);
  }
}

class Product {
  String uid;
  String name;
  String brand;
  String url;
  String hindi;
  bool available;
  dynamic mrp;
  dynamic price;
  dynamic pricediscount;
  int gst;
  int max ;
  int quantityOrdered;
  bool isAdded ;

  Product( this.uid,this.name, this.brand, this.url, this.hindi, this.available,
      this.price, this.pricediscount, this.gst, this.max,this.quantityOrdered,this.isAdded,this.mrp);

  Product.fromJson(DocumentSnapshot json) {
    uid = json.documentID;
    name = json['name'];
    brand = json['brand'];
    url = json['url'] ;
    hindi = json['hindi'];
    available = json['available'];
    price = json['price']  ;
    pricediscount = json['pricediscount'] ;
    gst = json['gst'];
    max = json['max'];
    quantityOrdered = json['qty'];
    mrp = json['price'] + json['pricediscount'];
    
  }
}
