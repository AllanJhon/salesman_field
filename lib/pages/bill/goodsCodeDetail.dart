import 'package:flutter/material.dart';

class GoodsCodeDetailPage extends StatelessWidget {
  final arguments;
  // const GoodsCodeDetailPage({Key key}) : super(key: key);
  
  GoodsCodeDetailPage({this.arguments});
  List _getMapData() {
    print(this.arguments.toString());
    List<Widget> list = new List();
    this.arguments.forEach((key, value) {
      list.add(
        Container(
          decoration: new BoxDecoration(
            border: Border(
              bottom: const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 12.0, 5.0, 5),
                  child: Text('$key:'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 15.0, 5.0, 5),
                  child: Text('$value'),
                ),
              ),
            ],
          ),
        ),
      );
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("要货码详情"),
          centerTitle: true,
        ),
        body: ListView(
          children: this._getMapData(),
        ));
  }
}
