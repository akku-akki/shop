import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/custom_size.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/screens/navigationScreens/cart.dart';
import 'package:shop/screens/navigationScreens/home.dart';
import 'package:shop/screens/navigationScreens/profile.dart';
import 'package:shop/screens/navigationScreens/search.dart';
import 'package:line_icons/line_icons.dart';


class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  PageController _controller;
  int currentScreen = 0;
  @override
  void initState() {
    _controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  void didChangeDependencies() {
   
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ref = CustomSize.customSize;

    return Theme(
      data: ThemeData(
        backgroundColor: Colors.grey[300],
                fontFamily: 'Serif',
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: ref.widthFactor * 16),
              headline2: TextStyle(fontSize: ref.widthFactor * 14,
                color: Colors.grey[600],
                  fontWeight: FontWeight.w700,),
              headline3: TextStyle(
                  fontSize: ref.widthFactor * 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              headline4: TextStyle(fontSize: ref.widthFactor * 10),
              headline5: TextStyle(fontSize: ref.widthFactor * 20,color: Colors.white,fontWeight: FontWeight.w600),
              headline6: TextStyle(fontSize: ref.widthFactor * 12,),
              subtitle1: TextStyle(fontSize: ref.widthFactor*14,color: Colors.white,fontWeight: FontWeight.w700)
              )),

      child: Scaffold(
        body: PageView.builder(
            pageSnapping: false,
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  return Home();
                case 1:
                  return Cart();
                case 2:
                  return Search();
                case 3:
                  return Profile();
              }
            }),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: currentScreen,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(LineIcons.home), title: Text(ConstNames.home)),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.shopping_cart),
                title: Text(ConstNames.cart)),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.search), title: Text(ConstNames.search)),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.user), title: Text(ConstNames.profile)),
          ],
          onTap: (index) {
            setState(() {
              currentScreen = index;
              _controller.animateToPage(currentScreen,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            });
          },
        ),
      ),
    );
  }
}
