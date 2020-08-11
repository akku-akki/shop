import 'package:flutter/material.dart';

Future commonDialog(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: OutlineButton(onPressed: (){
                Navigator.pop(context);
              },
              child: Text("close",style: TextStyle( color: Colors.red ),),color: Colors.red,),
            ),
            onTap: ()=>Navigator.pop(context),
          )
        ],
      );
    },
  );
}
