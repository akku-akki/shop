import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';

class UploadList extends StatelessWidget {
  const UploadList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width10, vertical: height8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width10),
            border: Border.all(color: Colors.orange)),
        child: ListTile(
          // onTap: _controller.onUploadPrescritpionWidgetClick,
          title: Text(
            ConstNames.uploadMyList,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            ConstNames.uploadMyListHindi,
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: CircleAvatar(
              backgroundColor: Colors.grey[800],
              radius: width28,
              child: Icon(
                LineIcons.camera,
                size: width30,
                color: Colors.orange,
              )),
        ),
      ),
    );
  }
}
