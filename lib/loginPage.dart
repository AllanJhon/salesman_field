import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesman_field/models/loginUser.dart';
import 'tabs.dart';
import 'resources/shared_preferences_keys.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/SYSTEMCONST.dart';
import 'service/loginAPI.dart';
import 'untils/shared_preferences.dart' show SpUtil;
import 'data/SAPCONST.dart';

TextEditingController _userController = TextEditingController();
TextEditingController _pwdController = TextEditingController();
String _user;
String _pwd;
bool isObscure = true;
bool isQ = true;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _userController.text = SpUtil.get("user");
    _pwdController.text = SpUtil.get("pwd");
    //判断是否登录
    checkLgin();
  }

  Future checkLgin() async {
    if (SpUtil.hasKey(SpUtil.get(SharedPreferencesKeys.userInfo))) {
      currentUser = LoginUser.get(
          json.decode(SpUtil.get(SharedPreferencesKeys.userInfo)));
    } else {
      SpUtil.putBool(SharedPreferencesKeys.isLogin, false);
    }

    if (SpUtil.hasKey(SharedPreferencesKeys.isLogin) &&
        SpUtil.getBool(SharedPreferencesKeys.isLogin)) {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Tabs()),
          (route) => route == null);
    }
  }

  Future _log() async {
    _user = _userController.text;
    _pwd = _pwdController.text;

    if (_user == null || _user.isEmpty) {
      _showToast("用户名不能为空!");
      return;
    }
    if (_pwd == null || _pwd.isEmpty) {
      _showToast("密码不能为空!");
      return;
    }

    Future<Null> _writerDataToFile() async {
      //后续删除, currentUser.toString() 写这个整串的意义是？
      SpUtil.putString(SharedPreferencesKeys.userInfo, currentUser.toString());
      SpUtil.putBool(SharedPreferencesKeys.isLogin, true);
      //写
      SpUtil.putString("user", _user);
      SpUtil.putString("pwd", _pwd);
      SpUtil.putBool("isLogin", true);
    }

    LoginAPI.login(_user, _pwd).then((loginUser) {
      if (loginUser == null) {
        _showToast("网络异常。");
        return;
      }
      if (this.mounted) {
        setState(() {
          if (!loginUser.loginUserList[0].isSucess) {
            _showToast(loginUser.loginUserList[0].error);
          } else {
            _writerDataToFile();
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => Tabs()),
                (route) => route == null);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: new Stack(children: <Widget>[
      new Opacity(
          opacity: 0.8,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/timg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Center(
            child: Text(
              "金隅冀东移动外勤",
              style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          new Center(
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isQ = !isQ;
                });
                flag = isQ ? "Q" : "P";
              },
              child: new Image.asset(
                'assets/images/normal_user_icon.png',
                width: MediaQuery.of(context).size.width * 0.25,
                color: isQ ? Colors.lightBlue[900]:Theme.of(context).primaryColor,
              ),
            ),
          ),
          // 双击切换环境用，生产环境可替换上面的代码
          // new Center(
          //    child: new Image.asset(
          //       'assets/images/normal_user_icon.png',
          //       width: MediaQuery.of(context).size.width * 0.25,
          //     ),
          //   ),

          new Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 0, 2),
                      child: new TextField(
                        controller: _userController,
                        // keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          hintText: '请输入用户名',
                          icon: new Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 0, 2),
                      child: new TextField(
                        controller: _pwdController,
                        obscureText: isObscure,
                        decoration: new InputDecoration(
                          hintText: '请输入密码',
                          icon: new Icon(
                            Icons.lock_outline,
                            size: 32,
                          ),
                          suffixIcon: new IconButton(
                            icon: Icon(isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            iconSize: 28,
                            onPressed: () async {
                              if (this.mounted) {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ])),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: new Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: new RaisedButton(
                    color: Colors.blue[700],
                    splashColor: Colors.black,
                    highlightColor: Colors.lightBlue[900],
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      _log();
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
          ),
          new Center(
              child: new FlatButton(
                  child: new Text("没有帐户？ 联系我们！"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        child: new SimpleDialog(
                          title: new Text(
                            CORPNAME,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          contentPadding: const EdgeInsets.all(8.0),
                          children: <Widget>[
                            Divider(
                              height: 8.0,
                              indent: 0.0,
                              color: Colors.grey,
                            ),
                            new Center(
                                child: new Image.asset(
                              QRCODE,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            new ListTile(
                                title: new Text("联系电话："),
                                subtitle: new Text(TELEPHONE),
                                trailing: new IconButton(
                                  icon: Icon(Icons.phone, color: Colors.green),
                                  onPressed: () {
                                    doCall("tel:$TELEPHONE");
                                  },
                                )),
                          ],
                        ));
                  }))
        ],
      )
    ])));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

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

doCall(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
