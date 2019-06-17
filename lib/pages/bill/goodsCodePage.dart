import 'package:flutter/material.dart';
import '../../data/listData.dart';

TextEditingController goodsController = TextEditingController();
TextEditingController goodsController1 = TextEditingController();

class GoodsCodePage extends StatefulWidget {
  GoodsCodePage({Key key}) : super(key: key);

  _GoodsCodePageState createState() => _GoodsCodePageState();
}

class _GoodsCodePageState extends State<GoodsCodePage> {
  var _res = "查询状态";
  bool _goodsStat = true;

  void _goSearch(flag) {
    _goodsStat = !_goodsStat;
    setState(() {
      _res = _goodsStat ? "要货码下发成功" : "要货码下发失败";
    });
  }

  List _getMapData() {
    List<Widget> list = new List();
    Map m1 = new Map();
    m1.forEach((key, value) {
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
        centerTitle: true,
        title: TextFileWidget(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 32),
              tooltip: '搜索',
              onPressed: () {
                print(goodsController.text);
                // _goSearch();
              })
        ],
      ),
      body: ListView.builder(
        itemCount: billData.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              title: Text(billData[index]["付货通知单号"]),
              onTap: () {
                Navigator.pushNamed(context, '/billD',
                    arguments: billData[index]);
              },
              trailing: billData[index]["flag"]
                  ? Icon(Icons.check_circle, size: 28, color: Colors.green)
                  : new PopupMenuButton(
                      onSelected: (String value) {
                        setState(() {
                          //  _bodyStr = value;
                          print(billData[index]["付货通知单号"]);
                          switch (value) {
                            case "query":
                              print("调用查询页面");
                              break;
                            case "send":
                              print("调用发送接口");
                              break;
                          }
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<String>>[
                            new PopupMenuItem(
                                value: "query", child: new Text("查看详情")),
                            new PopupMenuItem(
                                value: "send", child: new Text("重新下发"))
                          ]),
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

class TextFileWidget extends StatelessWidget {
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      controller: goodsController,
      cursorColor: Colors.black, //设置光标
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,
//            icon: Icon(Icons.search),
//            icon: ImageIcon(AssetImage("image/search_meeting_icon.png",),),
          // suffixIcon: new IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     // size: 3,
          //   ),
          // ),
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
