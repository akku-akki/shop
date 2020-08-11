import 'package:flutter/material.dart';
import 'package:shop/ScreenUtils/customSizedBox.dart';
import 'package:shop/firebaseRepo/profileRepo.dart';
import 'package:shop/offline/connectivity.dart';
import 'package:shop/offline/sharedPrefs.dart';
import 'package:shop/screens/globalWidgets/noDataWidget.dart';

class EditInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditInfoState();
  }
}

class EditInfoState extends State<EditInfo> {
  String _name = "";
  String _email = "";
  String _phone = "";
  String _address = "";
  String _userId = "";
  ProfileCat profile = ProfileCat();

  Future<bool> getDetails() async {
    _name = await OfflineDetails.getName() ?? "";
    _email = await OfflineDetails.getEmail() ?? "";
    _phone = await OfflineDetails.getPhone() ?? "";
    _address = await OfflineDetails.getAddress() ?? "";
    _userId = await OfflineDetails.getUserId() ?? "";
    print(_name);
    print(_email);
    print(_phone);
    print(_address);
    print(_userId);
    return true;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.only(top: height16, bottom: height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          border: Border.all(color: Colors.orange),
          color: Colors.white),
      child: TextFormField(
        initialValue: _name,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width6, vertical: height6),
            border: InputBorder.none,
            hintText: "Name",
            labelText: "Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: height16, bottom: height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          border: Border.all(color: Colors.orange),
          color: Colors.white),
      child: TextFormField(
        initialValue: _email,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width6, vertical: height6),
            border: InputBorder.none,
            hintText: "Email",
            labelText: "Email"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is Required';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email Address';
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Container(
      margin: EdgeInsets.only(top: height16, bottom: height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          border: Border.all(color: Colors.orange),
          color: Colors.white),
      child: TextFormField(
        maxLength: 10,
        initialValue: _phone,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width6, vertical: height6),
            border: InputBorder.none,
            hintText: "Phone",
            labelText: "Phone"),
        keyboardType: TextInputType.phone,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Phone number is Required';
          }
          return null;
        },
        onSaved: (String value) {
          // _url = value;
          _phone = value;
        },
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      margin: EdgeInsets.only(top: height16, bottom: height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width10),
          border: Border.all(color: Colors.orange),
          color: Colors.white),
      child: TextFormField(
        initialValue: _address,
        maxLines: null,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width6, vertical: height6),
            border: InputBorder.none,
            hintText: "Delivery Address",
            labelText: "Address"),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Required Address';
          }
          return null;
        },
        onSaved: (String value) {
          _address = value;
          print("I am Saved");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // resizeToAvoidBottomInset: ,
      appBar: AppBar(title: Text("Edit Info")),
      body: Container(
        margin: EdgeInsets.all(width12),
        child: FutureBuilder<bool>(
           future: CheckConnectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == false) return NoInternet();
            return ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: FutureBuilder<bool>(
                      future: getDetails(),
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: Text("Waiting"),
                          );
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildName(),
                            _buildEmail(),
                            _buildPhoneNumber(),
                            _buildAddress(),
                            SizedBox(height: 100),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                  padding: EdgeInsets.all(height16),
                                  shape: StadiumBorder(),
                                  color: Colors.orange,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontFamily: "Comfortaa",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      bool result = await profile.setProfile(
                                          _name, _phone, _address, _email, _userId);
                                      print("Response ${result.toString()}");
                                      if (result) {
                                        print(result);
                                        OfflineDetails.setUserDetails(
                                            add: _address,
                                            email: _email,
                                            name: _name,
                                            phone: _phone,val: true);
                                        Navigator.pop(context, true);
                                        print("SaveToDatabase");
                                        return;
                                      }
                                      Navigator.pop(context, false);
                                    }
                                  }),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
