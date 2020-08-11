import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/orderBloc.dart';
import 'package:shop/firebaseRepo/orderRepo.dart';
import 'package:shop/model/order.dart';
import 'package:shop/offline/connectivity.dart';
import 'package:shop/screens/childrenScreens/orderList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/screens/globalWidgets/noDataWidget.dart';

class MyOrder extends StatelessWidget {
  OrderRepo repo = OrderRepo();
  Future<String> calculateDate(DateTime time) async {
    switch (time.month) {
      case 1:
        return '${time.day} January ${time.year} ';
        break;
      case 2:
        return '${time.day} February ${time.year} ';
        break;
      case 3:
        return '${time.day} March ${time.year} ';
        break;
      case 4:
        return '${time.day} April ${time.year} ';
        break;
      case 5:
        return '${time.day} May ${time.year} ';
        break;
      case 6:
        return '${time.day} June ${time.year} ';
        break;
      case 7:
        return '${time.day} July ${time.year} ';
        break;
      case 8:
        return '${time.day} August ${time.year} ';
        break;
      case 9:
        return '${time.day} September ${time.year} ';
        break;
      case 10:
        return '${time.day} October${time.year} ';
        break;
      case 11:
        return '${time.day} November ${time.year} ';
        break;
      case 12:
        return '${time.day} December ${time.year} ';
        break;
      default:
        return 'No date available';
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterToast toast = FlutterToast(context);

    final orderBloc = Provider.of<OrderBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: FutureBuilder<bool>(
          future: CheckConnectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == false) return NoInternet();
            return Builder(builder: (contextk) {
              orderBloc.orderStatus.listen((event) {
                if (event != null) {
                  toast.showToast(
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: Duration(milliseconds: 1200),
                    child: Card(
                      color: event ? Colors.green : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          event ? "Your Order Is Deleted" : "Unable To Delete",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontFamily: ConstNames.comfortaa,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  );
                }
              });
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width8, vertical: height10),
                child: StreamBuilder(
                    stream: orderBloc.productList,
                    builder: (context, AsyncSnapshot<OrderList> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: Text("Loading....."),
                        );
                      if (snapshot.data == null)
                        return Center(
                          child: Text("No Shopping Yet"),
                        );
                      return Column(
                          children: snapshot.data.order
                              .map((e) => Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height8,
                                          horizontal: width8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              FutureBuilder<String>(
                                                  future:
                                                      calculateDate(e.dateTime),
                                                  builder: (context,
                                                      AsyncSnapshot<String>
                                                          snapshot) {
                                                    if (!snapshot.hasData)
                                                      return Text("");
                                                    return Text(
                                                      snapshot.data,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    );
                                                  }),
                                              Text(
                                                "${ConstNames.rupeeSymbol} ${e.priceToBePaid}/-",
                                                style: TextStyle(
                                                    color: Colors.brown[700],
                                                    fontFamily:
                                                        ConstNames.comfortaa,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                e.delivered
                                                    ? "Delivery : COMPLETED"
                                                    : "Delivery : ON THE WAY ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                        color: e.delivered
                                                            ? Colors.green[600]
                                                            : Colors
                                                                .amber[800]),
                                              ),
                                              Spacer(),
                                              e.delivered
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        orderBloc.cancelOrder(
                                                            e.documentId);
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            width4),
                                                                side:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                )),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height4,
                                                                  horizontal:
                                                                      width10),
                                                          child: Text(
                                                            "Cancel",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              GestureDetector(
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetails(
                                                              order: e.order,
                                                              cost: e
                                                                  .priceToBePaid
                                                                  .toString(),
                                                            ))),
                                                child: Card(
                                                  color: Colors.orange,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: height4,
                                                            horizontal:
                                                                width10),
                                                    child: Text(
                                                      "View",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList());
                    }),
              );
            });
          }),
    );
  }
}
