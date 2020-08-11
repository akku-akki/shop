import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Model {
  int id;
  int value1;
  int value2;

  Model({this.id, this.value1, this.value2});
}

List<Model> sampleModels = [
  Model(id: 123, value1: 0, value2: 1),
  Model(id: 120, value1: 2, value2: 3)
];

class Sample {
  final _modelFetcher = BehaviorSubject<List<Model>>.seeded(sampleModels);

  Stream<List<Model>> get products => _modelFetcher.stream;

  void add(Model m) {
    _modelFetcher.value.forEach((element) {
      if (element.id == m.id) {
        element.value1++;
      }
    });
  }

  void sub(Model m) {
    _modelFetcher.value.forEach((element) {
      if (element.id == m.id) {
        element.value1--;
      }
    });
  }

  void disposeb() {
    _modelFetcher.close();
  }
}

class SamplExe extends StatefulWidget {
  @override
  _SamplExeState createState() => _SamplExeState();
}

class _SamplExeState extends State<SamplExe> {
  Sample s = Sample();
  @override
  Widget build(BuildContext context) {
    print("rebuilding first screen");
    return Material(
      child: StreamBuilder<List<Model>>(
        stream: s._modelFetcher.stream,
        builder: (context, AsyncSnapshot<List<Model>> snapshot1) {
          print("rebuilding SecondScreen screen");

          if (!snapshot1.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
              itemCount: snapshot1.data.length,
              itemBuilder: (BuildContext context, index) {
                print("rebuilding ThirdScreen screen");
                return RowBuilder(
                  m: snapshot1.data[index],
                );
              });
        },
      ),
    );
  }
}

class RowBuilder extends StatefulWidget {
  final Model m;
  RowBuilder({
    Key key,
    this.m,
  }) : super(key: key);

  @override
  _RowBuilderState createState() => _RowBuilderState();
}

class _RowBuilderState extends State<RowBuilder> {
  Sample s = Sample();

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.m.value1.toString());
  }

  void add() {
    s.add(widget.m);
    print("added");
    controller.text = widget.m.value1.toString();
  }

  void sub() {
    s.sub(widget.m);
    print("Subtracted");
    controller.text = widget.m.value1.toString();
  }

  Widget build(BuildContext context) {
    print("rebuilding FourthScreen screen");
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(),
                controller: controller,
                enabled: false,
              ),
            ),
          ),
          RaisedButton(
            onPressed: add,
            child: Icon(Icons.add),
          ),
          RaisedButton(
            onPressed: sub,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
