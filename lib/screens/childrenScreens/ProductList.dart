import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/bloc/homeBloc.dart';
import 'package:shop/bloc/singleCounter.dart';
import 'package:shop/model/products.dart';
import 'package:shop/screens/globalWidgets/cartCounter.dart';
import 'package:shop/screens/globalWidgets/shimmer.dart';
import 'package:shop/screens/globalWidgets/productCard.dart';
class ProductList extends StatefulWidget {
  final String productCategorie;

  const ProductList({Key key, this.productCategorie}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

Future<String> returnString(String value) async {
  return "${value[0].toUpperCase()}${value.substring(1)}";
}

class _ProductListState extends State<ProductList> {
  CartBloc cartBloc;
  SingleProductBloc singleProductBloc;
  HomeBloc homeBloc;
  FlutterToast toast;

  @override
  void didChangeDependencies() {
    toast = FlutterToast(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = Provider.of<HomeBloc>(context);
    singleProductBloc = Provider.of<SingleProductBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: FutureBuilder<String>(
              future: returnString(widget.productCategorie),
              builder: (context, AsyncSnapshot<String> snapshot2) {
                if (!snapshot2.hasData) return Text("");
                return Text(
                  snapshot2.data,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                );
              }),
          actions: <Widget>[CartCounter()],
        ),
        body: Builder(builder: (BuildContext contextk) {
          singleProductBloc.meaasga.listen((event) {
            if (event != null) {
              toast.showToast(
                gravity: ToastGravity.BOTTOM,
                toastDuration: Duration(milliseconds: 1200),
                child: Card(
                  color: event ? Colors.green : Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event
                          ? "Product Added To Cart"
                          : "Product Already Exists",
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
          return StreamBuilder<bool>(
              stream: homeBloc.productLoading,
              builder: (context, AsyncSnapshot<bool> snapshot1) {
                if (snapshot1.data == true) return ProductListShimmer();
                return StreamBuilder<ProductListItems>(
                    stream: homeBloc.getProductList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return ProductListShimmer();
                      if (snapshot.hasError)
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      return ListView.builder(
                          itemCount: snapshot.data.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                           return ProductCard(singleProductBloc: singleProductBloc,product: snapshot.data.productList[index],);
                          });
                    });
              });
        }));
  }
}
