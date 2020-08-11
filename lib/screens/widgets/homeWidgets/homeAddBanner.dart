import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/external/carouselSlider.dart';
import 'package:shop/screens/globalWidgets/shimmer.dart';

class HomeAddBanner extends StatelessWidget {
  const HomeAddBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        height: MediaQuery.of(context).size.height * 0.25,
        showIndicator: true,
        indicatorEnableColor: Colors.grey[800],
        indicatorDisableColor: Colors.grey,
        items: [1, 2, 3, 4].map((e) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: width6),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://firebasestorage.googleapis.com/v0/b/shop-bc225.appspot.com/o/banner%2Fautumn-2690176_640.jpg?alt=media&token=12072ae4-22c5-4fd4-b25f-c4974be0be74",
              placeholder: (context, url) => AddShimmer(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }
}