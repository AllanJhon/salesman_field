import 'package:flutter/material.dart';
import '../../components/cate_card.dart';
import '../../components/widget_item_container.dart';
import '../../models/cat.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageWidgetState();
  }
}

class HomePageWidgetState extends State<HomePageWidget> {
  List<Cat> categories = [];

  @override
  void initState() {
    super.initState();
    renderCats();
  }

  void renderCats() {
    setState(() {
      Cat cat = new Cat(
          id: 1,
          name: '合同新增',
          desc: '合同新增',
          depth: 1,
          parentId: 0,
          path: 'contract/contract');
      categories.add(cat);
      Cat cat1 = new Cat(
          id: 1,
          name: '合同查询',
          desc: '合同查询',
          depth: 1,
          parentId: 0,
          path: '/busi');
      categories.add(cat1);
      Cat cat2 = new Cat(
          id: 1,
          name: '订单查询',
          desc: '订单查询',
          depth: 1,
          parentId: 0,
          path: '/bill');
      categories.add(cat2);
      Cat cat3 = new Cat(
          id: 1,
          name: '要货码查询',
          desc: '要货码查询',
          depth: 1,
          parentId: 0,
          path: '/cust');
      categories.add(cat3);
    });
  }

  Widget buildGrid() {
    // 存放最后的widget
    List<Widget> tiles = [];
    for (Cat item in categories) {
      tiles.add(new CateCard(category: item));
    }
    return new ListView(
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child:   GridView.count(
    //       crossAxisCount: 3,
    //       mainAxisSpacing: 10.0,
    //       crossAxisSpacing: 4.0,
    //       padding: const EdgeInsets.all(30.0),
    //       childAspectRatio: 1.3,
    //     children: <Widget>[
    //       GridTile(
    //         child: Container(
    //           child: IconButton(icon:Icon(Icons.add_a_photo),),
    //         ),
    //       ),
    //       GridTile(
    //         child: Container(
    //           child: Text("审批状态查询"),
    //         ),
    //       ),
    //     ],
    //   )
    // );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          '首页',
          style: TextStyle(
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {
              })
        ],
      ),
      body: 
      Container(
        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/paimaiLogo.png'),
              alignment: Alignment.bottomRight),
        ),
        child: WidgetItemContainer(
            categories: this.categories, columnCount: 3, isWidgetPoint: false),
      ),
    );
  }
}
