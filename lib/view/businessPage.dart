import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../untils/HttpUtil.dart';
// import 'package:second/view/homePage.dart';

var _txt="124";

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
    print(response.toString());

    setState(() {
     _txt = response.toString();
    });
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
            color: Colors.red,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
                // print('Shopping cart opened.');
                getData();
              })
        ],
      ),
      body: new Container(
        child: Text(_txt),
      )
    );
  }
}

class MyCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyContainer(),
    );
  }
}

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipOval(
        child: Image.network(
            "http://n.sinaimg.cn/default/1_img/upload/3933d981/701/w899h602/20190603/f796-hxvzhth0240471.jpg",
            width: 100,
            height: 100,
            fit: BoxFit.cover),
      ),
    );
  }
}


