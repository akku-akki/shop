import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';

class BillingRowDetails extends StatelessWidget {
  final String description;
  final Stream stream;
  const BillingRowDetails({
    Key key,
    this.description,
     this.stream, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height4),
      child: Row(
        children: <Widget>[
          Text(
            description,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.brown[800],
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
          Spacer(),
          StreamBuilder<double>(
            stream: stream,
            builder: (context,AsyncSnapshot<double> snapshot) {
              return Text(
                snapshot.data.toString(),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.brown[800],
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              );
            }
          )
        ],
      ),
    );
  }
}