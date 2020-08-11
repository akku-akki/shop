import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/searchBloc.dart';
import 'package:shop/bloc/singleCounter.dart';
import 'package:shop/model/products.dart';
import 'package:shop/offline/connectivity.dart';
import 'package:shop/screens/globalWidgets/noDataWidget.dart';
import 'package:shop/screens/globalWidgets/productCard.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchBloc>(context);
    final singleProductBloc = Provider.of<SingleProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[800],
        title: Container(
            padding: EdgeInsets.only(left: width8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width8),
                color: Colors.grey[100]),
            child: Row(
              children: <Widget>[
                Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.search,
                      size: width30,
                      color: Colors.grey[800],
                    )),
                SizedBox(
                  width: width8,
                ),
                Flexible(
                    flex: 10,
                    child: TextField(
                      onChanged: (String val) async {
                        print(val);
                        if (val == null) {
                          search.searchKeyWord("");
                        } else {
                          search.searchKeyWord(val);
                        }
                      },
                      style: TextStyle(
                          fontFamily: ConstNames.comfortaa,
                          color: Colors.black,
                          fontSize: width16),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search"),
                    ))
              ],
            )),
      ),
      body: FutureBuilder<bool>(
          future: CheckConnectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == false) return NoInternet();
            return Center(
              child: StreamBuilder<bool>(
                stream: search.loading,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text("Search"),
                    );
                  if (snapshot.data == true)
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[800],
                    ));
                  return StreamBuilder<ProductListItems>(
                    stream: search.products,
                    builder: (BuildContext context,
                        AsyncSnapshot<ProductListItems> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: Text("No Product Available"),
                        );
                      if (snapshot.data == null) return SizedBox();
                      return ListView.builder(
                          itemCount: snapshot.data.productList.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              singleProductBloc: singleProductBloc,
                              product: snapshot.data.productList[index],
                            );
                          });
                    },
                  );
                },
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
