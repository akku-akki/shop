import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/singleCounter.dart';
import 'package:shop/model/products.dart';
import 'package:shop/screens/globalWidgets/ZoomImage.dart';
import 'package:shop/screens/widgets/DetailsPopup/rowBilling.dart';
import 'package:shop/screens/widgets/DetailsPopup/weightCounter.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleProductBloc =
        Provider.of<SingleProductBloc>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        singleProductBloc.setMessage(null);
        singleProductBloc.clearData();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.all(width16),
              child: StreamBuilder<Product>(
                  stream: singleProductBloc.singleProduct,
                  builder: (context, AsyncSnapshot<Product> productSnap) {
                    if (!productSnap.hasData)
                      return (Center(
                        child: Text("No Data"),
                      ));
                    if (productSnap.data == null)
                      return (Center(
                        child: Text("No data in stream"),
                      ));
                    return Stack(
                      children: <Widget>[
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width12, vertical: height10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width20),
                                  color: Colors.grey[800]),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    productSnap.data.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(productSnap.data.hindi,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                            color: Colors.white,
                                          )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height10,
                            ),
                            SizedBox(
                              height: height4,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(width12),
                              height: MediaQuery.of(context).size.height * 0.7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width20),
                                  color: Colors.grey[300]),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "${ConstNames.rupeeSymbol} ${productSnap.data.mrp} /-   (Per Kg)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(color: Colors.brown[800]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "You Save ${ConstNames.rupeeSymbol} ${productSnap.data.pricediscount}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: Colors.green[700],
                                                fontFamily:
                                                    ConstNames.comfortaa,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ref.heightFactor * 30,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: WeightCounter(
                                        typeCounter: ConstNames.looseCounter,
                                        increment: () {
                                          singleProductBloc.quantityAdd();
                                        },
                                        decrement: () {
                                          singleProductBloc.quantityRemove();
                                        },
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height4),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "Total Quantity",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        color:
                                                            Colors.brown[800],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic),
                                              ),
                                              Spacer(),
                                              StreamBuilder<int>(
                                                stream:
                                                    singleProductBloc.totalOTY,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<int>
                                                        snapshot) {
                                                  return Text(
                                                      snapshot.data.toString());
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        BillingRowDetails(
                                          description: "Total MRP",
                                          stream: singleProductBloc.mrpSingle,
                                        ),
                                        BillingRowDetails(
                                          description: "You Saved !",
                                          stream: singleProductBloc.discount,
                                        ),
                                        BillingRowDetails(
                                          description: "Total for this item",
                                          stream: singleProductBloc.totalPrice,
                                        ),
                                        SizedBox(
                                          height: height16,
                                        ),
                                        StreamBuilder<bool>(
                                            stream: singleProductBloc.enabled,
                                            initialData: true,
                                            builder: (context,
                                                AsyncSnapshot<bool> snapshot) {
                                              return RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width10)),
                                                  color: Colors.orange,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: height16),
                                                    child: Text(
                                                      snapshot.data == true
                                                          ? "ADD TO CART"
                                                          : "No Valid Quantity",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: ""),
                                                    ),
                                                  ),
                                                  onPressed: snapshot.data
                                                      ? () {
                                                          singleProductBloc
                                                              .addToCart();
                                                          Navigator.pop(
                                                              context);
                                                          singleProductBloc
                                                              .clearData();
                                                        }
                                                      : null);
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: ref.heightFactor * 85,
                          left: 0.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: ref.widthFactor * 80,
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return ImageZoom();
                                      });
                                },
                                child: CircleAvatar(
                                  radius: ref.widthFactor * 68,
                                  backgroundImage:
                                      NetworkImage(productSnap.data.url),
                                )),
                          ),
                        )
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
