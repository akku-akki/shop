import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/bloc/singleCounter.dart';

class WeightCounter extends StatelessWidget {
  final String typeCounter;
  final VoidCallback increment;
  final VoidCallback decrement;
  const WeightCounter({
    Key key,
    this.typeCounter,
   this.increment, this.decrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final singleProductBloc =
        Provider.of<SingleProductBloc>(context, listen: false);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Select Quantity",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.brown[800], fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: width18,
            ),
          ],
        ),
        SizedBox(
          height: height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CounterButton(
              icon: Icons.add,
              onpressed: increment
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.25,
              padding:
                  EdgeInsets.symmetric(horizontal: width28, vertical: width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width8),
                  color: Colors.white,
                  border: Border.all(color: Colors.orange)),
              child: Center(
                child: StreamBuilder<int>(
                    stream: singleProductBloc.totalOTY,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.brown[700]),
                      );
                    }),
              ),
            ),
            CounterButton(
              icon: Icons.remove,
              onpressed:  decrement
            ),
          ],
        ),
      ],
    );
  }
}

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onpressed;
  const CounterButton({
    Key key,
    this.icon,
    this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.all(width10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width28),
          border: Border.all(color: Colors.orange),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: Colors.amber,
        ),
      ),
    );
  }
}
