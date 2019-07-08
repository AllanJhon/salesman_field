import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/SAPCONST.dart';
import '../../models/goodsCode.dart';
import '../../untils/ProgressDialog.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
var date = new DateTime.now();
bool _loading = false;
var _search;

String timestamp =
    "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}";
String md5Sign =
    md5.convert(utf8.encode(timestamp + "WQWS")).toString().toUpperCase();
String inputxmlstr;
FocusNode _contentFocusNode = FocusNode();

class GoodsCodePage1 extends StatefulWidget {
  _GoodsCodePageState1 createState() => _GoodsCodePageState1();
}

class _GoodsCodePageState1 extends State<GoodsCodePage1> {
  var _index;
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

  Future _sendGoodsCode(GoodsCode goodsCode) async {
    inputxmlstr =
        '<![CDATA[<?xml version="1.0" encoding="UTF-8"?> <ZIF_BH_ORDER><ZSEND_NO>' +
            goodsCode.send_no +
            '</ZSEND_NO></ZIF_BH_ORDER>]]>';
    String soap = '''
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
        <soapenv:Body>
            <urn:ZIF_WQ_IN_WS>
              <FLAG>YHMXF</FLAG>
             <INPUTXMLSTR>$inputxmlstr</INPUTXMLSTR>
              <SIGN>$md5Sign</SIGN>
              <TS>$timestamp</TS>
            </urn:ZIF_WQ_IN_WS>
        </soapenv:Body>
      </soapenv:Envelope>''';
    var response = await http.post(Uri.parse(sapURL),
        headers: sapHeader,
        body: utf8.encode(soap),
        encoding: Encoding.getByName("UTF-8"));
    if (response.statusCode != 200) {
      print("Server Error !!!" + response.statusCode.toString());
    }
    setState(() {
      var document = xml.parse(response.body);
      var outputxmlstr = document.findAllElements('OUTPUTXMLSTR').single.text;
      var result = xml
          .parse(outputxmlstr)
          .findAllElements('RESULT')
          .map((node) => new GoodsResult(
              node.findElements('Status').single.text,
              node.findElements('Message').single.text))
          .toList();
      if (result.length > 0) {
        goodsCode.zflag = (result[0].status == "S" ? "Y" : "N");
        _showToast(result[0].message);
      }
      _index = -1;
    });
  }

  Future _getGoodsCodeList(int start) async {
    _search = goodsController.text;
    // if (_search == null || _search.isEmpty || _search.length < 3) {
    //   // if (new DateTime.now().difference(priTouchTime).inSeconds > 5) {
    //   _showToast("请输入至少三位要货码");
    //   // priTouchTime = new DateTime.now();
    //   // }
    //   return;
    // }
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
    var response = await http.post(Uri.parse(sapURL),
        headers: sapHeader,
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
          .map((node) => new GoodsCode(node.findElements('SEND_NO').single.text,
              node.findElements('ZFLAG').single.text))
          .toList();
      _loading = false;
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
              onPressed: () async {
                _search = goodsController.text;
                _contentFocusNode.unfocus();
                if (_search == null || _search.isEmpty || _search.length < 3) {
                  _showToast("请输入至少三位要货码");
                  return;
                }
                setState(() {
                  _loading = true;
                });
                _getGoodsCodeList(0);
              })
        ],
      ),
      body: _loading
          ? new Center(
              child: ProgressDialog(
              loading: _loading,
              msg: '正在加载...',
              child: Center(
                  // child: RaisedButton(
                  //   onPressed: () => null,
                  //   child: Text('显示加载动画'),
                  // ),
                  ),
            ))
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                      title: Text(_dataList[index].send_no),
                      enabled: _dataList[index].zflag == "N" ? true : false,
                      onTap: () {
                        // _showToast();
                      },
                      onLongPress: () {
                        if (_dataList[index].zflag == "N") {
                          setState(() {
                            _index = index;
                            _sendGoodsCode(_dataList[index]);
                          });
                        }
                      },
                      trailing: new Container(
                          child: (_index == index)
                              ? new CircularProgressIndicator(
                                  backgroundColor: Color(0xffff0000))
                              : new Icon(
                                  _dataList[index].zflag == "Y"
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  size: 28,
                                  color: _dataList[index].zflag == "Y"
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
          hintText: "请输入至少三位要货码",
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
