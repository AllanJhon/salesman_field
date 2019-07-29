import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesman_field/models/loginUser.dart';
import 'tabs.dart';
import 'resources/shared_preferences_keys.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/SYSTEMCONST.dart';
import 'service/loginAPI.dart';
import 'untils/shared_preferences.dart';

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
    //读取本地存储的用户名、密码
    _readLoginData().then((Map onValue) {
      
      if (this.mounted){
        setState(() {
          _user = onValue["user"];
          _pwd = onValue["pwd"];
          _md5PWD = onValue["md5PWD"];
          _userController.text = _user;
          _pwdController.text = _pwd;
        });
      }
    });
    //判断是否登录
    checkLgin();
    
  }
  Future checkLgin() async {
    SpUtil sharePeferences =   await SpUtil.getInstance();
    if(sharePeferences.hasKey(sharePeferences.get(SharedPreferencesKeys.userInfo))){
      currentUser=LoginUser.get(json.decode(sharePeferences.get(SharedPreferencesKeys.userInfo)));
    }else{
      sharePeferences.putBool(SharedPreferencesKeys.isLogin,false);
    }

    if(sharePeferences.hasKey(SharedPreferencesKeys.isLogin)&&sharePeferences.getBool(SharedPreferencesKeys.isLogin)){
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
    _md5PWD = md5.convert(utf8.encode(_pwd)).toString();

    Future<Null> _writerDataToFile() async {
      await (await _getLocalFile())
          .writeAsString('{"user":"$_user","pwd":"$_pwd","md5PWD":"$_md5PWD"}');

      SpUtil sp= await SpUtil.getInstance();
      sp.putString(SharedPreferencesKeys.userInfo, currentUser.toString());
      sp.putBool(SharedPreferencesKeys.isLogin,true);
    }

    LoginAPI.login(_user, _pwd).then((loginUser) {
      if (loginUser == null) {
        _showToast("网络异常");
        return;
      }
      if (this.mounted){
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
            child: Text(
              "金隅冀东移动外勤",
              style: TextStyle(
                  color: Colors.lightBlue[900], fontSize: 32, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
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
                        // keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          hintText: '请输入用户名',
                          icon: new Icon(
                            Icons.person,
                            size: 32,
                          ),
                        ),
                        onSubmitted: (value) {
                          // _checkInput();
                        },
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
                              if (this.mounted){
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
                    // color: Colors.green,
                    color: Colors.lightBlue[700],
                    splashColor:Colors.black,
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

Future<File> _getLocalFile() async {
  //获取应用程序的私有位置
  String dir = (await getApplicationDocumentsDirectory()).path;
  return new File('$dir/login.txt');
}

doCall(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
