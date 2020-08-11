import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:shop/screens/childrenScreens/editprofile.dart';
import 'package:shop/screens/childrenScreens/upiPayment.dart';
import 'package:shop/screens/widgets/toast.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  FlutterToast toast;
  @override
  Widget build(BuildContext context) {
    toast = FlutterToast(context);
    final cartBloc = Provider.of<CartBloc>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(width16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: height8, horizontal: width8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width8),
                    border: Border.all(color: Colors.grey[400]),
                    color: Colors.grey[800]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.orange,
                        ),
                        Text(
                          "\tDeliver At :",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: ConstNames.comfortaa,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        GestureDetector(
                          child: Icon(
                            LineIcons.edit,
                            color: Colors.white,
                          ),
                          onTap: () async {
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
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: height8,
                    ),
                    FutureBuilder<String>(
                      future: OfflineDetails.getAddress(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) return Text("");
                        return Text(
                          snapshot.data,
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    SizedBox(
                      height: height8,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: width10,
                        ),
                        FutureBuilder<String>(
                          future: OfflineDetails.getPhone(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) return Text("");
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ConstNames.comfortaa,
                                  letterSpacing: 1.2),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 40),
                child: Text(
                  "Please Choose Your Payment Option",
                  style: TextStyle(
                      fontFamily: ConstNames.comfortaa,
                      fontWeight: FontWeight.w700),
                ),
              ),
              PaymentButton(
                method: "Cash On Delivery",
                c: Colors.grey[800],
                onTap: () async {
                  bool result = await cartBloc.placeOrder();
                  if (result) {
                    cartBloc.clear();
                    toast.showToast(
                        child: ToastWidget(
                          text: "Your Order Is Placed",
                          c: Colors.orange,
                        ),
                        toastDuration: Duration(seconds: 2),
                        gravity: ToastGravity.BOTTOM);
                  } else {
                    toast.showToast(
                        child: ToastWidget(
                          text: "Failed to Place Order",
                          c: Colors.grey[800],
                        ),
                        toastDuration: Duration(seconds: 2),
                        gravity: ToastGravity.BOTTOM);
                  }
                },
              ),
              SizedBox(
                height: height16,
              ),
              PaymentButton(
                  method: "UPI",
                  c: Colors.orange,
                  onTap: () async {
                    bool result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UpiPayment()));
                    if (result) {
                      cartBloc.clear();
                      toast.showToast(
                          child: ToastWidget(
                            text: "Transaction Completed",
                            c: Colors.orange,
                          ),
                          toastDuration: Duration(seconds: 1),
                          gravity: ToastGravity.BOTTOM);
                    } else {
                      toast.showToast(
                          child: ToastWidget(
                            text: "Transaction Failed",
                            c: Colors.orange,
                          ),
                          toastDuration: Duration(seconds: 1),
                          gravity: ToastGravity.BOTTOM);
                    }
                  }),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String method;
  final Color c;
  final VoidCallback onTap;
  PaymentButton({
    Key key,
    this.method,
    this.onTap,
    this.c,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: height16),
        color: c,
        onPressed: onTap,
        shape: StadiumBorder(),
        child: Text(
          method,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
