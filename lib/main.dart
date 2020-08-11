import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/bloc/homeBloc.dart';
import 'package:shop/bloc/login.dart';
import 'package:shop/bloc/orderBloc.dart';
import 'package:shop/bloc/searchBloc.dart';
import 'package:shop/bloc/singleCounter.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:shop/screens/initScreen/login.dart';
import 'ScreenUtils/custom_size.dart';
import 'offline/connectivity.dart';
import 'screens/globalWidgets/noDataWidget.dart';
import 'screens/initScreen/shop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchBloc>(create: (_) => SearchBloc()),
        Provider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
        Provider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        Provider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        Provider<SingleProductBloc>(
          create: (_) => SingleProductBloc(),
        ),
        Provider<OrderBloc>(
          create: (_) => OrderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Serif',
          iconTheme: IconThemeData(color: Colors.grey[700]),
          primaryColor: Colors.grey[800],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Builder(
          builder: (BuildContext context) {
            CustomSize.initialize(MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width);
            return FutureBuilder<bool>(
                future: CheckConnectivity.checkConnectivity(),
                builder: (context, snapshot) {
                  final home = Provider.of<HomeBloc>(context);
                  final loginBloc = Provider.of<LoginBloc>(context);
                  loginBloc.homeBloc = home;
                  final orderBloc = Provider.of<OrderBloc>(context);

                  final cartBloc =
                      Provider.of<CartBloc>(context, listen: false);
                  cartBloc.order = orderBloc;
                  final singleProductBloc =
                      Provider.of<SingleProductBloc>(context);
                  singleProductBloc.cartBloc = cartBloc;
                  home.loadHomeItems();
                  if (snapshot.data == false) return NoInternet();
                  return FutureBuilder(
                      future: OfflineDetails.checkUserStatus(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey[700],
                              ),
                            ),
                          );
                        } else if (snapshot.data == true) {
                          return Shop();
                        } else {
                          return LoginScreen();
                        }
                      });
                });
          },
        ),
      ),
    );
  }
}
