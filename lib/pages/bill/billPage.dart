import 'package:flutter/material.dart';
import '../../untils/ProgressDialog.dart';
import '../../service/billAPI.dart';
import '../../models/loginUser.dart';
import '../../tabs.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
var date = new DateTime.now();
bool _loading = false;
bool _isSucess = false;
var warningNum = 100;
var msg;

var zksrq; //开始时期
var zjsrq; //结束日期
var zvkbur; //销售部门
var zvkgrp; //销售组
var zkunnr; //客户编号
var zbstkd; //客户采购订单编号

class BillPage extends StatefulWidget {
  final arguments;
  BillPage({this.arguments});
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataList.clear();

    zvkbur = currentUser.salesOffice;
    zvkgrp = currentUser.salesCode;

    zksrq = this.widget.arguments != null
        ? this.widget.arguments["vBegDate"]
        : DateTime.now()
            .add(new Duration(days: -14))
            .toString()
            .substring(0, 10)
            .replaceAll("-", ""); //默认开始日期为两周前

    zjsrq = this.widget.arguments != null
        ? this.widget.arguments["vEendDate"]
        : DateTime.now()
            .toString()
            .substring(0, 10)
            .replaceAll("-", ""); //默认结束日期为今天

    zbstkd =
        this.widget.arguments != null ? this.widget.arguments["billNo"] : "";
    zkunnr =
        this.widget.arguments != null ? this.widget.arguments["cusName"] : "";

    _loading = true;
    _getBillList();
  }

  Future _getBillList() async {
    BillAPI.xml2List(zksrq, zjsrq, zvkbur, zvkgrp, zkunnr, zbstkd)
        .then((billModel) {
      setState(() {
        _dataList = billModel.billModelList;
        _isSucess = _dataList.length > 0 ? _dataList[0].isSucess : _isSucess;
        msg = _dataList.length > 0 ? _dataList[0].message : "调用远端服务异常!";
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: '后退',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => Tabs()),
                  (route) => route == null);
              ;
            }),
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
      body: _loading
          ? new Center(
              child: ProgressDialog(
              loading: _loading,
              msg: '正在加载...',
              child: Center(),
            ))
          : !_isSucess
              ? new Center(
                  child: Text(
                    msg,
                    style: TextStyle(
                        fontSize: 24, color: Theme.of(context).primaryColor),
                  ),
                )
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        title: Text(
                          "" +
                              _dataList[index].zname1 +
                              ", 余量：" +
                              _dataList[index].zskwmeng +
                              "吨,  ",
                          style: double.parse(_dataList[index].zskwmeng) <
                                  warningNum
                              ? TextStyle(color: Colors.red)
                              : TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("订单号:" +
                            _dataList[index].zbstkd +
                            ", " +
                            "单价:" +
                            _dataList[index].zdj +
                            ", 品种:" +
                            _dataList[index].zarktx +
                            ", 销往:" +
                            _dataList[index].zxwdq),
                        onTap: () {
                          Navigator.pushNamed(context, '/billD',
                              arguments: _dataList[index]);
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              width: 1)),
                    );
                  },
                ),
    );
  }
}
