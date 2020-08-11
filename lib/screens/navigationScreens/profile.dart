import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/ScreenUtils/custom_size.dart';
import 'package:shop/bloc/orderBloc.dart';
import 'package:shop/firebaseRepo/loginRepo.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:shop/screens/childrenScreens/editprofile.dart';
import 'package:shop/screens/childrenScreens/myOrders.dart';
import 'package:shop/screens/initScreen/login.dart';
import 'package:shop/screens/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final ref = CustomSize.customSize;

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin  {
  TextStyle s = TextStyle(
      fontFamily: "Cursive",
      fontSize: ref.widthFactor * 64,
      color: Colors.white,
      fontWeight: FontWeight.w900);

  FlutterToast toast;

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    toast = FlutterToast(context);
    return Center(
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: height16, horizontal: width18),
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                child:  Image.asset("assets/ic_launcher.png",fit: BoxFit.contain,width: ref.widthFactor*120,height: ref.heightFactor*110,),

                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                          future: OfflineDetails.getName(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == "")
                              Text("");
                              if(snapshot.data==null) return SizedBox();
                            return Text(snapshot.data,
                                style: TextStyle(
                                    color: Colors.brown[700],
                                    fontSize: ref.widthFactor * 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Comfortaa",
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 1.2));
                          }),
                      SizedBox(
                        height: height6,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                bool result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditInfo()));
                                if (result) {
                                  toast.showToast(
                                      child: ToastWidget(
                                        text: "Profile Updated",
                                        c: Colors.orange,
                                      ),
                                      toastDuration: Duration(seconds: 1),
                                      gravity: ToastGravity.BOTTOM);
                                  setState(() {});
                                } else {
                                  toast.showToast(
                                      child: ToastWidget(
                                        text: "Failed Updating",
                                        c: Colors.grey[800],
                                      ),
                                      toastDuration: Duration(seconds: 2),
                                      gravity: ToastGravity.BOTTOM);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(width8),
                                    border: Border.all(color: Colors.orange)),
                                padding: EdgeInsets.all(width6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Edit"),
                                    SizedBox(
                                      width: width6,
                                    ),
                                    Icon(LineIcons.edit)
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              child: IconButton(
                                  icon: Icon(
                                    LineIcons.power_off,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          content: Text("Confirm SignOut"),
                                          contentTextStyle:
                                              TextStyle(color: Colors.red[600]),
                                          actions: <Widget>[
                                            OutlineButton(
                                              onPressed: () async {
                                                bool val =
                                                    await LoginRepo.signOut();
                                                if (val) {
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()));
                                                } else {
                                                  toast.showToast(
                                                    child: ToastWidget(
                                                      text: "Unable To SignOut",
                                                      c: Colors.orange,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text("Yes"),
                                            ),
                                            OutlineButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"),
                                            )
                                          ],
                                        ));
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: height16,
            ),
            SizedBox(
              height: height16,
            ),
            FutureBuilder(
                future: OfflineDetails.getName(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData || snapshot.data == "")
                    return ProfileRowInfo(
                      icon: LineIcons.user,
                      desc: "Name",
                    );
                  return ProfileRowInfo(
                    icon: LineIcons.user,
                    desc: snapshot.data,
                  );
                }),
            FutureBuilder(
                future: OfflineDetails.getEmail(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData || snapshot.data == "")
                    return ProfileRowInfo(
                      icon: LineIcons.envelope,
                      desc: "Email",
                    );
                  return ProfileRowInfo(
                    icon: LineIcons.envelope_o,
                    desc: snapshot.data,
                  );
                }),
            FutureBuilder(
                future: OfflineDetails.getPhone(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData || snapshot.data == "")
                    return ProfileRowInfo(
                      icon: LineIcons.mobile_phone,
                      desc: "Moblie",
                    );
                  return ProfileRowInfo(
                    icon: LineIcons.mobile_phone,
                    desc: snapshot.data,
                  );
                }),
            FutureBuilder(
                future: OfflineDetails.getAddress(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData || snapshot.data == "")
                    return ProfileRowInfo(
                      icon: LineIcons.home,
                      desc: "Address",
                    );
                  return ProfileRowInfo(
                    icon: LineIcons.home,
                    desc: snapshot.data,
                  );
                }),
            GestureDetector(
              onTap: () {
                orderBloc.getMyOrders();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyOrder()));
              },
              child: ProfileRowInfo(
                icon: LineIcons.list_alt,
                desc: "My Orders",
              ),
            ),
            GestureDetector(
              child: ProfileRowInfo(
                icon: LineIcons.share,
                desc: "Contact Us",
              ),
              onTap: () async {
                const url = "tel:+917558221805";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                   toast.showToast(child: ToastWidget(
                    text: "Failed",
                    c: Colors.black,
                  ));
                  throw 'Could not launch $url';
                 
                }
              },
            ),
          ],
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProfileRowInfo extends StatelessWidget {
  final IconData icon;
  final String desc;
  const ProfileRowInfo({
    Key key,
    this.icon,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width12),
          side: BorderSide(color: Colors.orange)),
      margin: EdgeInsets.symmetric(horizontal: width8, vertical: height8),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height16, horizontal: width8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: width4, right: width6),
                  child: Icon(
                    icon,
                    color: Colors.grey[800],
                  ),
                )),
            Flexible(
              flex: 12,
              child: Text(
                desc,
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.brown,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Comfortaa",
                    letterSpacing: 1.1),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
