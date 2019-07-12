import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/goodsCode.dart';
import '../../service/GoodsCode_api.dart';
import '../../untils/ProgressDialog.dart';
import 'package:connectivity/connectivity.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
bool _loading = false;
var _search;

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

  Future<bool> networkCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future _sendGoodsCode(GoodsCode goodsCode) async {
    GoodsCodeAPI.sendGoodsCode(goodsCode).then((goodsResult) {
      setState(() {
        if (goodsResult.goodResultList.length > 0) {
          goodsCode.zflag =
              (goodsResult.goodResultList[0].status == "S" ? "Y" : "N");
          _showToast(goodsResult.goodResultList[0].message);
        }
        _index = -1;
      });
    });
  }

  Future _getGoodsCodeList(int start) async {
    if (!await networkCheck()) {
      _showToast("当前无网络");
      return;
    }

    GoodsCodeAPI.getGoodsCodeList(_search).then((goodsCode) {
      setState(() {
        _dataList = goodsCode.goodsCodesList;
        _loading = false;
      });
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
              child: Center(),
            ))
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                      title: Text(_dataList[index].sendno),
                      enabled: _dataList[index].zflag == "N" ? true : false,
                      onTap: () {
                        print(_dataList[index].sendno);
                        _showToast("长按以下发此要货码。");
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
