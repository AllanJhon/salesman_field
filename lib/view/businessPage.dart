import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:second/view/homePage.dart';

class BusinessPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BusinessPageWidgetState();
  }
}

class BusinessPageWidgetState extends State<BusinessPageWidget> {
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
                print('Shopping cart opened.');
              })
        ],
      ),
      body: Stack(
            children: <Widget>[
              Positioned(
                  left: 150.0,
                  top: 20.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffff0000),
                  )
              ),
              Positioned(
                  left: 150.0,
                  top: 70.0,
                  child: CircularProgressIndicator(
                    value: 0.3,
                    backgroundColor: Color(0xffff0000),
                  )
              ),
              Positioned(
                  left: 150.0,
                  top: 120.0,
                  child: CircularProgressIndicator(
//                    value: 0.3,
                    strokeWidth: 4.0,
                    backgroundColor: Color(0xffff0000),
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  )
              ),
              Positioned(
                  left: 150.0,
                  top: 170.0,
                  child: CircularProgressIndicator(
//                    value: 0.3,
                    strokeWidth: 8.0,
                    backgroundColor: Color(0xffff0000),
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  )
              ),
              Positioned(
                  left: 150.0,
                  top: 220.0,
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
//                    value: 0.3,
                      backgroundColor: Color(0xffff0000),
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  )
              ),
            ],
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

class MyContainer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          "如何高效实现混合云环境中的容器迁移？英特尔有办法",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 20.0,
            decoration: TextDecoration.lineThrough,
            letterSpacing: .0,
          ),
        ),
        height: 120.0,
        width: 120.0,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        transform: Matrix4.translationValues(-80, -10, 0));
  }
}

class HomeContent extends StatelessWidget {
  List<Widget> getData() {
    List<Widget> list = new List();
    for (var i = 0; i < 20; i++) {
      list.add(Container(
        child: ListTile(
          title: Text("这是第$i个标题"),
          subtitle: Text("第$i个子内容详情，第$i个子内容详情，第$i个子内容详情，第$i个子内容详情"),
        ),
      ));
    }
    return list;
  }

  List<Widget> _getData1(context) {
    List listData = [
      {"title": "普通硅酸盐水泥^散装^盾石  余量:100.00吨", "owner": "金庸", "primary": "CSFQDSNO5N119050145  单价:435元/吨 2019-05-27 销往：唐山市路北区"},
      {"title": "天龙八部1", "owner": "金庸", "primary": "乔峰、段誉、慕容复、阿朱、阿紫"},
      {"title": "陆小凤", "owner": "古龙", "primary": "陆小凤、司空摘星、花满楼、牛肉汤"}
    ];

    var tempList = listData.map((value) {
      return Container(
        child: ListTile(
          title: Text(value["title"] + value["owner"]),
          subtitle: Text(value["primary"]),
          onTap: (){
            print(value["title"]);
            // Navigator.pushNamed(context, '/product');
             //Navigator.pushNamed(context, '/product',arguments: listData[0]);
          },
        ),
        decoration: BoxDecoration(
            //加边框的效果
            border: Border.all(
                color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      );
    });
    return tempList.toList();
  }
  
  @override
  Widget build(BuildContext context) { 
    return ListView(children: this._getData1(context));
  }
}
