import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../untils/HttpUtil.dart';
import 'dart:convert';
// import 'package:second/view/homePage.dart';

var _txt="124";
List<Widget> _list = new List();

class BusinessPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BusinessPageWidgetState();
  }
}

class BusinessPageWidgetState extends State<BusinessPageWidget> {

  Future getData() async {
    // String url = Api.NEWS_LIST;
    String url = "http://api.map.baidu.com/telematics/v3/weather?location=%E5%8C%97%E4%BA%AC";
    var data = {'output': 'json', 'ak': 'L3QvWfpbRAroheCG9ePBMijx'};
    var response = await HttpUtil().get(url,queryParameters: data);

    // responseBody = await response.transform(utf8.decoder).join();
    Map<String,Object> mapData = json.decode(response.toString());

    setState(() {
    //  _txt = response.toString();
    mapData.forEach((key, value) {
      _list.add(
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

    });
    print(_list.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
         leading: new IconButton(
          icon: new Icon(Icons.vpn_key),
          tooltip: 'Navigation menu',
          onPressed:null,
        ),
        centerTitle: true,
        title: new Text(
          '订单',
          style: TextStyle(
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
                getData();
              })
        ],
      ),
      body:
        ListView(
            children:_list,
        )
      //  new Container(
      //   child: ListView(
      //       children:_list,
      //   )
      // )
    );
  }
}






