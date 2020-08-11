import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/model/products.dart';

class CartCounter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cartBloc = Provider.of<CartBloc>(
      context,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Icon(
              LineIcons.shopping_cart,
              color: Colors.orange,
              size: width40,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                maxRadius: width10,
                backgroundColor: Colors.white,
                child: StreamBuilder<List<Product>>(
                    stream: cartBloc.productList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text("0");
                      return Text(
                        snapshot.data.length.toString(),
                        style: TextStyle(
                            fontSize: width12,
                            fontFamily: ConstNames.comfortaa,
                            fontWeight: FontWeight.w700),
                      );
                    }),
              ),
            )
          ],
        ),
        SizedBox(
          width: width10,
        )
      ],
    );
  }
}