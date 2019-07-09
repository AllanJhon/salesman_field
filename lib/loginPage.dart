import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tabs.dart';

/*
 *注册界面
 */
TextEditingController _userController = TextEditingController();
TextEditingController _pwdController = TextEditingController();
String _user;
String _pwd;
String _md5PWD;
bool isObscure = true;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _readLoginData().then((Map onValue) {
      setState(() {
        _user = onValue["user"];
        _pwd = onValue["pwd"];
        _md5PWD = onValue["md5PWD"];
        _userController.text = _user;
        _pwdController.text = _pwd;
      });
    });
  }

  Future<Map> _readLoginData() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/login.txt');
    String data = await file.readAsString();
    Map json = new JsonDecoder().convert(data);
    return json;
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
      new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Center(
              child: new Image.asset(
            'assets/images/normal_user_icon.png',
            width: MediaQuery.of(context).size.width * 0.3,
          )),
          new Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 0, 2),
                      child: new TextField(
                        controller: _userController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          hintText: '请输入用户名',
                          icon: new Icon(
                            Icons.person,
                            size: 36,
                          ),
                        ),
                        onSubmitted: (value) {
                          // _checkInput();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 0, 2),
                      child: new TextField(
                        controller: _pwdController,
                        obscureText: isObscure,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: '请输入密码',
                          icon: new Icon(
                            Icons.lock_outline,
                            size: 36,
                          ),
                          suffixIcon: new IconButton(
                            icon: Icon(isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            iconSize: 28,
                            onPressed: () async {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          // _checkInput();
                        },
                      ),
                    ),
                  ])),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: new Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: new RaisedButton(
                    // color: Colors.green,
                    color: Colors.lightBlue[800],
                    highlightColor: Colors.green[900],
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      _log(context);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
          ),
          new Center(
              child: new FlatButton(
                  child: new Text("没有帐户？ 注册"),
                  onPressed: () {
                    // _openSignUp;
                  }))
        ],
      )
    ])));
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

Future<File> _getLocalFile() async {
  //获取应用程序的私有位置
  String dir = (await getApplicationDocumentsDirectory()).path;
  return new File('$dir/login.txt');
}

_log(context) {
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

  _md5PWD = md5.convert(utf8.encode(_pwd)).toString();

  Future<Null> _writerDataToFile() async {
    await (await _getLocalFile())
        .writeAsString('{"user":"$_user","pwd":"$_pwd","md5PWD":"$_md5PWD"}');
  }

  _writerDataToFile();
  // Navigator.pushNamed(context, "/tabs");
  Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(builder: (context) => Tabs()),
      (route) => route == null);
}
