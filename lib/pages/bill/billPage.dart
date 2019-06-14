import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/listData.dart';

class BillPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BillPageWidgetState();
  }
}

class BillPageWidgetState extends State<BillPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          '订单管理',
          style: TextStyle(
            // color: Colors.red,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
                   Navigator.pushNamed(context, '/billSearch');
              })
        ],
      ),
      body: MyHomeContent(),
    );
  }
}

class MyHomeContent extends StatefulWidget {
  MyHomeContent({Key key}) : super(key: key);
  _MyHomeContentState createState() => _MyHomeContentState();
}

class _MyHomeContentState extends State<MyHomeContent> {
  int warningNum = 100;

  @override
  Widget build(BuildContext context) {
    // return ListView(children: this._getBillData1(context));
    return ListView.builder(
      itemCount: billData.length,
      itemBuilder: (context, index) {
        return Container(
          
          child: ListTile(
            title: Text(
              "" +
                  billData[index]["客户编码"] +
                  ", 余量：" +
                  billData[index]["剩余量"] +
                  "吨",
              style: int.parse(billData[index]["剩余量"]) < warningNum
                  ? TextStyle(color: Colors.red)
                  : TextStyle(color: Colors.black),
            ),
            subtitle: Text("" +
                billData[index]["付货通知单号"] +
                ", " +
                "单价:" +
                billData[index]["材料单价"] +
                ", 品种:" +
                billData[index]["品种"] +
                ", 销往:" +
                billData[index]["销往地区"]),
            onTap: () {
              Navigator.pushNamed(context, '/billD',
                  arguments: billData[index]);
            },
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
        );
      },
    );
  }
}
