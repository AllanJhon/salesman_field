import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:oktoast/oktoast.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
var date = new DateTime.now();
String timestamp =
    "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
String md5Sign =
    md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
String inputxmlstr;

FocusNode _contentFocusNode = FocusNode();

class GoodsCodePage1 extends StatefulWidget {
// _
  _GoodsCodePageState1 createState() => _GoodsCodePageState1();
}

class _GoodsCodePageState1 extends State<GoodsCodePage1> {
  var _index;

  void _showCustomWidgetToast() {
    var w = Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        color: Colors.black.withOpacity(0.7),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              '添加成功',
              style: TextStyle(color: Colors.white),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
    showToastWidget(w);
  }

  Future getCustomerList(int start) async {
    _contentFocusNode.unfocus();
    var _search = goodsController.text;
    if (_search == null || _search.isEmpty) {
      // showToast("请输入至少三位要货码", position: ToastPosition.bottom);
      _showCustomWidgetToast();
      return;
    }
    if (_search.length < 2) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请输入至少三位要货码'),
              ));
      return;
    }
    inputxmlstr =
        '<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER><ZSEND_NO>' +
            _search +
            '</ZSEND_NO></ZIF_BH_ORDER>]]>';

    String soap = '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
        <soapenv:Body>
            <urn:ZIF_WQ_IN_WS>
              <FLAG>YHMCX</FLAG>
             <INPUTXMLSTR>$inputxmlstr</INPUTXMLSTR>
              <SIGN>$md5Sign</SIGN>
              <TS>$timestamp</TS>
            </urn:ZIF_WQ_IN_WS>
        </soapenv:Body>
      </soapenv:Envelope>''';

    var response = await http.post(
        Uri.parse(
            'http://dstbj.jdsn.com.cn:8081/sap/bc/srt/rfc/sap/zif_wq_in_ws/102/service/binding'),
        headers: {
          "SOAPAction":
              "urn:sap-com:document:sap:rfc:functions:Zif_WQ_IN_WS:ZIF_WQ_IN_WSRequest",
          "Content-Type": "text/xml;charset=UTF-8",
          'Authorization': 'Basic VFJGQzAxOjEyMzQ1Ng=='
        },
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));
    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
    }
    setState(() {
      var document = xml.parse(response.body);
      var outputxmlstr = document.findAllElements('OUTPUTXMLSTR').single.text;
      _dataList = xml
          .parse(outputxmlstr)
          .findAllElements('DATA')
          .map((node) => (node.findElements('SEND_NO').single.text +
              "-" +
              node.findElements('ZFLAG').single.text))
          .toList();
    });

    goodsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFileWidget(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 32),
              tooltip: '搜索要货码',
              onPressed: () {
                getCustomerList(0);
              })
        ],
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
                title: Text(
                    _dataList[index].substring(0, _dataList[index].length - 2)),
                onTap: () {},
                onLongPress: () {
                  if (_dataList[index].substring(_dataList[index].length - 1) ==
                      "N") {
                    setState(() {
                      _index = index;
                      new Future.delayed(new Duration(seconds: 3), () async {
                        setState(() {
                          // _dataList[index]["flag"] = !_dataList[index]["flag"];
                          _index = -1;
                        });
                      }).then((data) {
                        // print(data);
                      });
                    });
                  }
                },
                trailing: new Container(
                    child: (_index == index)
                        ? new CircularProgressIndicator(
                            backgroundColor: Color(0xffff0000))
                        : new Icon(
                            _dataList[index].substring(
                                        _dataList[index].length - 1) ==
                                    "Y"
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 28,
                            color: _dataList[index].substring(
                                        _dataList[index].length - 1) ==
                                    "Y"
                                ? Colors.green
                                : Colors.red))),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 1), width: 1)),
          );
        },
      ),
    );
  }
}

class TextFileWidget extends StatelessWidget {
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      controller: goodsController,
      focusNode: _contentFocusNode,
      cursorColor: Colors.black, //设置光标
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,
          hintText: "请输入要货码",
          hintStyle: new TextStyle(fontSize: 18, color: Colors.black26)),
      style: new TextStyle(fontSize: 18, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        //修饰黑色背景与圆角
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.white10, width: 1.0), //灰色的一层边框
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 40,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(),
      );
    }

    var cancleView = new Text("");

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: editView(),
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
          ),
          child: cancleView,
        )
      ],
    );
  }
}
