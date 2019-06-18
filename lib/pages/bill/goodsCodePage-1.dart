import 'package:flutter/material.dart';
import '../../data/listData.dart';

TextEditingController goodsController = TextEditingController();
List _dataList = new List();
FocusNode _contentFocusNode = FocusNode();

_getState(){
//模拟一个获取状态的方法，按照随机数获取，技术代表失败，偶数代表成功


}

class GoodsCodePage1 extends StatefulWidget {
// _
  _GoodsCodePageState1 createState() => _GoodsCodePageState1();
}

class _GoodsCodePageState1 extends State<GoodsCodePage1> {
  var _index;
  bool _goodsStat = true; 

  void _goSearch() {
    _contentFocusNode.unfocus();
    setState(() {
      var _search = goodsController.text;
      if (_search == null || _search.isEmpty) {
        return;
      } else {
        _dataList = billData1.where((value) {
          return value["付货通知单号"].toString().contains(_search);
        }).toList();
      }
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
              tooltip: '搜索',
              onPressed: () {
                _goSearch();
              })
        ],
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
                title: Text(_dataList[index]["付货通知单号"]),
                onTap: () {},
                onLongPress: () {
                  if (!_dataList[index]["flag"]) {
                    setState(() {
                      _index = index;
                      new Future.delayed(new Duration(seconds: 3), () async {
                        setState(() {
                          _dataList[index]["flag"] = !_dataList[index]["flag"];
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
                            _dataList[index]["flag"]
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 28,
                            color: _dataList[index]["flag"]
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
