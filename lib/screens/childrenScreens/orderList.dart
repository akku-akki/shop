import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/model/order.dart';

class OrderDetails extends StatefulWidget {
  final List<dynamic> order;
  final String cost;
  const OrderDetails({Key key, this.order, this.cost}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    //  final o = widget.order as List<Map<String,dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
              padding: EdgeInsets.all(width12),
              children: widget.order
                  .map((e) => SIngleitemCostDetails(item: e))
                  .toList()),
          Align(
              alignment: Alignment.bottomCenter,
              child: TotalCostOrder(
                cost: widget.cost,
              )),
        ],
      ),
    );
  }
}

class SIngleitemCostDetails extends StatelessWidget {
  final Map<String, dynamic> item;
  const SIngleitemCostDetails({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width6),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item["name"]),
                      SizedBox(
                        height: ref.heightFactor * 1,
                      ),
                      Text(
                        item['qty'].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontFamily: "Comfortaa"),
                      )
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Text(
                    "${ConstNames.rupeeSymbol} ${item['qty'] * item['price']}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontFamily: "Comfortaa"),
                  ))
            ],
          ),
          Divider(
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}

class TotalCostOrder extends StatelessWidget {
  final String cost;
  const TotalCostOrder({
    Key key,
    this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width10),
          side: BorderSide(color: Colors.grey[800])),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height16, horizontal: width16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Total",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.orange, fontWeight: FontWeight.w800),
            ),
            Text(
              "${ConstNames.rupeeSymbol} ${cost} /-",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.w800,
                  fontFamily: ConstNames.comfortaa),
            )
          ],
        ),
      ),
    );
  }
}
