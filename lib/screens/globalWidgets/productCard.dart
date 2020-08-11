
import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/staticNames.dart';
import 'package:shop/bloc/singleCounter.dart';
import 'package:shop/model/products.dart';
import 'package:shop/screens/childrenScreens/DetailsPopup.dart';

class ProductCard extends StatelessWidget {
   ProductCard({
    Key key,
    @required this.singleProductBloc, this.product,
  }) : super(key: key);

  final SingleProductBloc singleProductBloc;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height8),
          side: BorderSide(
            color: Colors.grey,
          )),
      margin: EdgeInsets.symmetric(
          horizontal: width8, vertical: height6),
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.all(width8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  height: ref.heightFactor * 120,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              height8),
                      image: DecorationImage(
                        image:product
                                    .url !=
                                null
                            ? AssetImage(
                                "assets/Rice.jpg")
                            : NetworkImage(
                             product
                                    .url,
                              ),
                        fit: BoxFit.cover,
                      )),
                )),
            SizedBox(
              width: width10,
            ),
            Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product
                          .brand,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(
                              color: Colors.deepOrange),
                    ),
                    SizedBox(
                      height: height4,
                    ),
                    Text(
                      product.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(
                            fontWeight: FontWeight.w400,color: Colors.black
                          ),
                    ),
                    SizedBox(
                      height: height4,
                    ),
                    Text(
                    product
                          .hindi,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ref.widthFactor * 16,
                        color: Colors.blueGrey[600],
                      ),
                    ),
                    SizedBox(
                      height: height8,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "MPR ${ConstNames.rupeeSymbol} ${product.price} /-",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                                color:
                                    Colors.brown[700],
                              ),
                        ),
                        SizedBox(
                          width: height4,
                        ),
                        Text(
                          "(Per Kg)",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(
                                  color: Colors
                                      .blueGrey[600],
                                  fontStyle:
                                      FontStyle.italic,
                                  fontWeight:
                                      FontWeight.w300),
                        ),
                        Spacer(),
                        Text(
                          "Off ${ConstNames.rupeeSymbol} ${product.pricediscount} /-",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                                  color: Colors
                                      .deepOrange),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height6,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${ConstNames.rupeeSymbol} ${product.pricediscount} /-",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(
                                  color: Colors
                                      .brown[700]),
                        ),
                        SizedBox(
                          width: height6,
                        ),
                        Text(
                          "(offer price)",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(
                                  color: Colors
                                      .blueGrey[600],
                                  fontStyle:
                                      FontStyle.italic,
                                  fontWeight:
                                      FontWeight.w300),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      width8)),
                          materialTapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap,
                          color: Colors.orange,
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    ref.widthFactor *
                                        12),
                          ),
                          onPressed: () {
                            Product p = product
                              ..quantityOrdered = 1;
                            singleProductBloc
                                .onSingleProductAdd(p);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetails()));
                          }),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
