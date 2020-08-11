import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class LoadingDisplay extends StatefulWidget {
  @override
  _LoadingDisplayState createState() => _LoadingDisplayState();
}

class _LoadingDisplayState extends State<LoadingDisplay> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(width10),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: width10,
          mainAxisSpacing: width10),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width8),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class ProductListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, int index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 150,
                margin:const EdgeInsets.all(8),
                padding:
                    EdgeInsets.symmetric(horizontal: width8, vertical: height6),
                color: Colors.white,
              ),
            );
          }),
    );
  }
}

class AddShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
