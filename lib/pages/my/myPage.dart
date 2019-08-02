import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../../models/loginUser.dart";
import '../../untils/shared_preferences.dart' show SpUtil;
import '../../resources/shared_preferences_keys.dart';
import 'package:flutter/services.dart';

var userName;
var salesCode;
var salesOffice;

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    userName = currentUser.userName;
    salesCode = currentUser.salesCode;
    salesOffice = currentUser.salesOffice;
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            '我的',
            style: TextStyle(
                // color: Colors.red,
                ),
          ),
        ),
        body: Container(
          child: Column(children: <Widget>[
            new Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 120,
                      width: 120,
                      child: new Image.asset(
                        'assets/images/normal_user_icon.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: new Container(
                      child: new Center(
                        child: ListTile(
                          title: Text(
                            currentUser.displayName,
                            style: TextStyle(fontSize: 22),
                          ),
                          subtitle: Text('''用户名:$userName
销售员编码:$salesCode
销售办公室编码:$salesOffice'''),
                          // Text("用户名:" +
                          //     currentUser.userName +
                          //     ", 销售员编码:" +
                          //     currentUser.salesCode +
                          //     ", 销售办公室编码:" +
                          //     currentUser.salesOffice),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: new Container(
                color: Colors.grey[300],
              ),
            ),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("修改密码"),
                leading: new Icon(
                  Icons.lock_outline,
                  size: 26,
                  color: Colors.green,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/password");
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("设置"),
                leading: new Icon(
                  Icons.settings,
                  color: Colors.orange[300],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/myConfig");
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("版本更新"),
                leading: new Icon(
                  Icons.system_update,
                  color: Colors.amber[900],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/upgrade");
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("切换用户"),
                leading: new Icon(
                  Icons.rotate_left,
                  color: Colors.pink[300],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () {
                  outLogin(context);
                },
              ),
            ),
            SizedBox(height: 3),
            new Container(
              color: Colors.white,
              child: ListTile(
                title: Text("退出登录"),
                leading: new Icon(
                  Icons.exit_to_app,
                  color: Colors.red[400],
                  size: 26,
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  size: 26,
                ),
                onTap: () async {
                  await pop();
                },
              ),
            ),
          ]),
          color: Colors.grey[100],
        ));
  }
}

Future outLogin(BuildContext context) async {
  SpUtil.remove(SharedPreferencesKeys.userInfo);
  SpUtil.putBool(SharedPreferencesKeys.isLogin, false);
  Navigator.popAndPushNamed(context, "/");
}
