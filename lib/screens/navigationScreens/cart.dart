import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/model/products.dart';
import 'package:shop/bloc/orderBloc.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:shop/screens/childrenScreens/checkout.dart';
import 'package:shop/screens/childrenScreens/editprofile.dart';
import 'package:shop/screens/globalWidgets/cartCounter.dart';
import 'package:shop/screens/widgets/toast.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with AutomaticKeepAliveClientMixin  {
  FlutterToast toast;

  @override
  Widget build(BuildContext context) {
    toast = FlutterToast(context);

    final cartBloc = Provider.of<CartBloc>(
      context,
    );
  
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "My Cart",
        ),
        actions: <Widget>[CartCounter()],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ref.widthFactor * 10,
                      vertical: ref.heightFactor * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      StreamBuilder<List<Product>>(
                          stream: cartBloc.productList,
                          builder:
                              (context, AsyncSnapshot<List<Product>> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            }
                            if (snapshot.data.isEmpty) {
                              print("emptyCart");
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      LineIcons.opencart,
                                      color: Colors.orange,
                                      size: height150,
                                    ),
                                    SizedBox(
                                      height: height10,
                                    ),
                                    Text(
                                      "Your Cart is Empty!",
                                      style: TextStyle(
                                          fontFamily: ConstNames.comfortaa,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2),
                                    )
                                  ],
                                ),
                              );
                            }
                            print("ItemCardDetailsCard");
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data
                                    .map((e) => ItemCartDetailCard(
                                          product: e,
                                          bloc: cartBloc,
                                        ))
                                    .toList());
                          }),
                      SizedBox(
                        height: ref.heightFactor * 10,
                      ),
                      StreamBuilder<List<Product>>(
                          stream: cartBloc.productList,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return SizedBox();
                            if (snapshot.data.isEmpty) return SizedBox();
                            if (snapshot.data == null) return SizedBox();
                            if (snapshot.data.isNotEmpty)
                              return Column(
                                children: <Widget>[
                                  PricingRow(
                                    pricingType: "Total MRP",
                                    stream: cartBloc.mrp,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ref.heightFactor * 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "You Save",
                                          style: TextStyle(
                                              color: Colors.green[600],
                                              fontSize: ref.widthFactor * 16),
                                        ),
                                        StreamBuilder<double>(
                                            stream: cartBloc.discountPrice,
                                            builder: (context,
                                                AsyncSnapshot<double>
                                                    snapshot) {
                                              if (snapshot == null)
                                                return Text("");
                                              return Text(
                                                  " - \u20B9 ${snapshot.data}",
                                                  style: TextStyle(
                                                      color: Colors.green[700],
                                                      fontSize:
                                                          ref.widthFactor *
                                                              16));
                                            })
                                      ],
                                    ),
                                  ),
                                  PricingRow(
                                    pricingType: "Order Total",
                                    stream: cartBloc.totalOrderPrice,
                                  ),
                                  PricingRow(
                                    pricingType: "Delivery",
                                    stream: cartBloc.deliveryCost,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ref.heightFactor * 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "To be paid",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ref.widthFactor * 16),
                                        ),
                                        StreamBuilder<double>(
                                            stream: cartBloc.priceToBePaid,
                                            builder: (context,
                                                AsyncSnapshot<double>
                                                    snapshot) {
                                              if (snapshot == null)
                                                return Text("");

                                              return Text(
                                                  "\u20B9 ${snapshot.data}",
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          ref.widthFactor *
                                                              16));
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            return SizedBox();
                          })
                    ],
                  )),
              SizedBox(
                height: ref.heightFactor * 5,
              ),
              SizedBox(
                height: ref.heightFactor * 100,
              )
            ],
          ),
          StreamBuilder<List<Product>>(
              stream: cartBloc.productList,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (!snapshot.hasData) return SizedBox();
                if (snapshot.data.isEmpty) return SizedBox();
                if (snapshot.data == null) return SizedBox();
                if (snapshot.data.isNotEmpty)
                  return Padding(
                    padding: EdgeInsets.all(width10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: height10, horizontal: width20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width8)),
                        onPressed: () async {
                          bool result =
                              await OfflineDetails.hasUserDetails() ?? false;
                          if (result) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Checkout()));
                          } else {
                            bool result2 = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditInfo()));
                            if (result2) {
                              toast.showToast(
                                  child: ToastWidget(
                                    text: "Profile Updated",
                                    c: Colors.orange,
                                  ),
                                  toastDuration: Duration(seconds: 1),
                                  gravity: ToastGravity.BOTTOM);
                            } else {
                              toast.showToast(
                                  child: ToastWidget(
                                    text: "Failed Updating",
                                    c: Colors.grey[800],
                                  ),
                                  toastDuration: Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            }
                          }
                        },
                        color: Colors.grey[800],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  StreamBuilder<double>(
                                      stream: cartBloc.priceToBePaid,
                                      builder: (context, snapshot) {
                                        if (snapshot == null)
                                          return Text("null");
                                        return Text("\u20B9 ${snapshot.data}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ref.widthFactor * 18,
                                            ));
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              width: ref.widthFactor,
                              height: ref.heightFactor * 25,
                              color: Colors.white70,
                            ),
                            Spacer(),
                            Text(
                              "CHECKOUT\t\t",
                              style: TextStyle(
                                  fontSize: ref.widthFactor * 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.directions_walk,
                              color: Colors.orange,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                return SizedBox();
              })
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



class ItemCartDetailCard extends StatefulWidget {
  final Product product;
  final CartBloc bloc;
  ItemCartDetailCard({
    Key key,
    this.product,
    this.bloc,
  }) : super(key: key);

  @override
  _ItemCartDetailCardState createState() => _ItemCartDetailCardState();
}

class _ItemCartDetailCardState extends State<ItemCartDetailCard> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.product.quantityOrdered.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ref.heightFactor * 1, bottom: ref.heightFactor * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: ref.widthFactor * 1,
                  horizontal: ref.heightFactor * 8),
              height: ref.heightFactor * 100,
              width: ref.widthFactor * 80,
              child: Image.network(
                widget.product.url,
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3)),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ref.heightFactor * 7,
                ),
                Text(
                  widget.product.name,
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontSize: ref.widthFactor * 18),
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ref.heightFactor * 8, bottom: ref.heightFactor * 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "₹ ${widget.product.price}",
                        style: TextStyle(
                            fontSize: ref.widthFactor * 16,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            widget.bloc.onProductIncrease(widget.product);
                            controller.text =
                                widget.product.quantityOrdered.toString();
                          },
                          child: Icon(
                            LineIcons.angle_double_up,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: width6,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: ref.widthFactor * 17,
                          child: Center(
                            child: TextField(
                              enabled: false,
                              controller: controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none, isDense: true),
                              style: TextStyle(
                                  fontSize: ref.widthFactor * 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[800]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width6,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.bloc.onProductDecrease(widget.product);
                            controller.text =
                                widget.product.quantityOrdered.toString();
                          },
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(LineIcons.angle_double_up,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(LineIcons.times_circle_o, color: Colors.grey),
                      onPressed: () {
                        widget.bloc.onProductRemove(widget.product);
                      },
                      iconSize: width30,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PricingRow extends StatelessWidget {
  PricingRow({
    this.pricingType,
    Key key,
    this.stream,
  }) : super(key: key);
  final Stream stream;
  final String pricingType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ref.heightFactor * 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pricingType,
            style: TextStyle(
                color: Colors.brown[700], fontSize: ref.widthFactor * 16),
          ),
          StreamBuilder<double>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot == null) return Text("");
                return Text("\u20B9 ${snapshot.data}",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: ref.widthFactor * 16));
              })
        ],
      ),
    );
  }
}
