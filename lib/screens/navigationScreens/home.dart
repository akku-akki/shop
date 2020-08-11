import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/bloc/homeBloc.dart';
import 'package:shop/model/homeProducts.dart';
import 'package:shop/screens/childrenScreens/ProductList.dart';
import 'package:shop/screens/globalWidgets/noDataWidget.dart';
import 'package:shop/screens/globalWidgets/shimmer.dart';
import 'package:shop/screens/widgets/homeWidgets/homeAddBanner.dart';
import 'package:shop/model/faliure.dart';
import 'package:shop/offline/connectivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin  {

  void navigate(String key) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductList(
                  productCategorie: key,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<bool>(
          future: CheckConnectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == false) return NoInternet();
            return RefreshIndicator(
              onRefresh: homeBloc.loadHomeItems,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: height10,
                  ),
                  SizedBox(
                    height: height10,
                  ),
                  HomeAddBanner(),
                  StreamBuilder<bool>(
                      stream: homeBloc.getLoading,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data == true) return LoadingDisplay();
                        return StreamBuilder(
                            stream: homeBloc.faliure,
                            builder:
                                (context, AsyncSnapshot<Faliure> snapshot3) {
                              if (snapshot3.hasData)
                                return Center(
                                  child: Text(snapshot3.data.message),
                                );
                              return StreamBuilder<DisplayList>(
                                  stream: homeBloc.getitemList,
                                  builder: (context,
                                      AsyncSnapshot<DisplayList> listItem) {
                                    if (!listItem.hasData)
                                      return LoadingDisplay();
                                    if (listItem.data.displayItems.length ==
                                            0 ||
                                        listItem.data == null)
                                      return Center(
                                        child: Text("No Data Found"),
                                      );
                                    return GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(width10),
                                        itemCount:
                                            listItem.data.displayItems.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: width10,
                                                mainAxisSpacing: width10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                print(listItem.data
                                                    .displayItems[index].key);
                                                homeBloc.getSingularProductList(
                                                    listItem
                                                        .data
                                                        .displayItems[index]
                                                        .key);
                                                navigate(listItem.data
                                                    .displayItems[index].key);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width8),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        listItem
                                                            .data
                                                            .displayItems[index]
                                                            .url,
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            footer: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width6,
                                                    vertical: height4),
                                                decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius
                                                                    .circular(
                                                                        width8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    width8))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      listItem
                                                          .data
                                                          .displayItems[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                    Text(
                                                      listItem
                                                          .data
                                                          .displayItems[index]
                                                          .hindi,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                  ],
                                                )),
                                          );
                                        });
                                  });
                            });
                      })
                ],
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.grey.shade700,
    );
  }
}
