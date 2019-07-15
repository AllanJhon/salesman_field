import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../untils/ProgressDialog.dart';
import '../../service/billAPI.dart';
import '../../models/billModel.dart';
import '../../models/loginUser.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
var date = new DateTime.now();
bool _loading = false;
var warningNum;

var zksrq = '09.12.2014'; //开始时期
var zjsrq = '20.12.2014'; //结束日期
var zvkbur; //销售部门
var zvkgrp; //销售组
var zkunnr; //客户编号
var zflag; //交货状态
var zbstkd; //客户采购订单编号

void _showToast(String toastMsg) {
  Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red[400],
      textColor: Colors.white,
      fontSize: 16.0);
}

class BillPageNew extends StatefulWidget {
  final arguments;
  BillPageNew({this.arguments});
  _BillPageNewState createState() => _BillPageNewState();
}

class _BillPageNewState extends State<BillPageNew> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zvkbur = currentUser.salesOffice;
    zvkgrp = currentUser.salesCode;
    zksrq = this.widget.arguments != null ?  this.widget.arguments["vBegDate"]:"默认开始日期";
    zjsrq = this.widget.arguments != null ?  this.widget.arguments["vEendDate"]:"默认结束日期";
    zbstkd = this.widget.arguments != null ? this.widget.arguments["billNo"]:"订单编号";
    zkunnr = "";
    zflag = "Y";
    print("............................$zjsrq");
    _getBillList();
  }

  Future _getBillList() async {
    BillAPI.xml2List(zksrq, zjsrq, zvkbur, zvkgrp, zkunnr, zflag, zbstkd)
        .then((billModel) {
      setState(() {
        _dataList = billModel.billModelList;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: '后退',
          onPressed: () {
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
        ],
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              title: Text(
                "" +
                    _dataList[index]["ZNAME1"] +
                    ", 余量：" +
                    _dataList[index]["ZSKWMENG"] +
                    "吨,  " +
                    _dataList[index]["ZERDAT"],
                style: int.parse(_dataList[index]["ZSKWMENG"]) < warningNum
                    ? TextStyle(color: Colors.red)
                    : TextStyle(color: Colors.black),
              ),
              subtitle: Text("" +
                  _dataList[index]["ZBSTKD"] +
                  ", " +
                  "单价:" +
                  _dataList[index]["ZBSTKD"] +
                  ", 品种:" +
                  _dataList[index]["ZMATNR"] +
                  ", 销往:" +
                  _dataList[index]["ZXWDQ"]),
              onTap: () {
                Navigator.pushNamed(context, '/billD',
                    arguments: _dataList[index]);
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
