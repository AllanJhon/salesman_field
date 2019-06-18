import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/listData.dart';

// List filterListDate;

class BillPage extends StatelessWidget {
  final arguments;
  int warningNum = 100;  //先模拟一个预警量的值

  BillPage({this.arguments});

  _getFilterListView() {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: '后退',
          onPressed: (){
            Navigator.pushNamed(context, '/tabs');
          },
        ),
        centerTitle: true,
        title: new Text(
          '订单查询',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
                Navigator.pushNamed(context, '/billSearch');
              }),
          IconButton(
              icon: Icon(Icons.cached),
              tooltip: '测试',
              onPressed: () {
                _getFilterListView();
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: billData.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              title: Text(
                "" +
                    billData[index]["客户编码"] +
                    ", 余量：" +
                    billData[index]["剩余量"] +
                    "吨,  " +
                    billData[index]["创建日期"],
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
                    color: Color.fromRGBO(233, 233, 233, 1), width: 1)),
          );
        },
      ),
    );
  }
}
