import 'package:flutter/material.dart';
import 'pages/home/homePage.dart';
import 'pages/bill/billPage.dart';
import 'pages/my/myPage.dart';
import 'pages/customer/CustomerPage.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key,this.index=0}) : super(key: key);

  _TabsState createState() => _TabsState(index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex=0;
  _TabsState(index){
    this._currentIndex = index;
  }
  List _listPage=[
    HomePageWidget(),
    CustomerPage(),
    MyPage(),
    BillPage()];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _listPage[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
            setState(() {
             this._currentIndex=index; 
            });
          },
          fixedColor: Colors.red,
           type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
            BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("客户")),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), title: Text("我的")),
          ],
        ),
        drawer: Drawer(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: UserAccountsDrawerHeader(
                    accountName:Text("陆小凤"),
                    accountEmail: Text("luxiaofeng@163.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage("http://ww1.sinaimg.cn/large/679db862jw1eu39hc1hagj21hd0u0n2m.jpg"),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.people),),
              title: Text("客户"),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.settings),),
              title: Text("设置"),
            ),
             Divider(),
          ],),
        ),
        );
  }
}
