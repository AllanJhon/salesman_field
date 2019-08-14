import 'package:flutter/material.dart';
import 'pages/home/homePage.dart';
import 'pages/my/myPage.dart';
import 'models/loginUser.dart';
import 'pages/outwork/outWork.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key, this.index = 0}) : super(key: key);

  _TabsState createState() => _TabsState(index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  _TabsState(index) {
    this._currentIndex = index;
  }
  List _listPage = [HomePageWidget(), OutWork(), MyPage(), ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        fixedColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), title: Text("外勤")),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new), title: Text("我的")),
        ],
      ),
/*      
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: UserAccountsDrawerHeader(
                    accountName: Text(currentUser.displayName),
                    accountEmail: Text(""),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: 
                      NetworkImage(
                          ""),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.settings),
              ),
              title: Text("设置"),
              onTap: () =>Navigator.pushNamed(context, "/myConfig")
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.lock),
              ),
              title: Text("修改密码"),
              onTap: () {
                Navigator.pushNamed(context, "/password");
              },
            ),
            Divider(),
          ],
        ),
      ),
*/
    );
  }
}
