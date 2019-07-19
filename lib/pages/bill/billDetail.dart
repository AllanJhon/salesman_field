import 'package:flutter/material.dart';
import '../../models/billModel.dart';

class BillDetail extends StatelessWidget {
  final arguments;
  BillDetail({this.arguments});

  List _getMapData() {

    // InstanceMirror instance_mirror = reflect(t);
    BillModel b ;
    b = this.arguments;
    List<Widget> list = new List();


    BillModel.billModel2Map(this.arguments).forEach((key, value) {
      list.add(
           Container(
              decoration: new BoxDecoration(
                border: Border(
                  bottom:
                      const BorderSide(width: 1.0, color: Color(0xFFEFEFEF)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 12.0, 5.0, 5),
                      // child: Text('$key:'),
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
          title: Text("订单详情页"),
          centerTitle: true,
        ),
        body:  
        ListView(
          children:
           this._getMapData(),
        )
        );
  }
}
