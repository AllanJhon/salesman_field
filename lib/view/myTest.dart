import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import "dart:math";

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  _log() {
    print(".................");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("图表"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(children: <Widget>[
          new Container(
            child: Text("ssssssssss"),
          ),
          SizedBox(height: 20,),
          new Container(
            padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: new FlatButton(
                      color: Colors.grey[350],
                      onPressed: _log,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.elliptical(15, 15)),
                        side: BorderSide(
                          color: Colors.grey[350],
                          width: 1,
                        ),
                      ),
                      child: new Text(
                        "合同执行情况",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(0, 0.0, 15.0, 0.0),
                    child: new FlatButton(
                      color: Colors.blue,
                      onPressed: null,
                      child: new Text(
                        "合同执行情况",
                        style: TextStyle(fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.elliptical(15, 15)),
                        side: BorderSide(
                          color: Colors.grey[200],
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  // ),
                ),
              ],
            ),
          )
        ])));
  }
}
