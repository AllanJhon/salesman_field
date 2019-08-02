import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesman_field/models/loginUser.dart';
import 'dart:async';
import '../../untils/shared_preferences.dart' show SpUtil;
import '../../service/loginAPI.dart';

var _oldPWDController = TextEditingController();
var _newPWDController = TextEditingController();
var _confirmPWDController = TextEditingController();
var _oldPWD;
var _newPWD;
var _confirmPWD;
var _localPWD;
bool oldObscure = true;
bool pressDown = false;
var _user = currentUser.userName;

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  void initState() {
    super.initState();
    _localPWD = SpUtil.get("pwd");
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

  //写数据
  Future<Null> _writerDataToFile() async {
    var confirmPWD = _confirmPWDController.text;
    SpUtil.putString("pwd", confirmPWD);
  }

  bool _changePWD() {
    _oldPWD = _oldPWDController.text;
    _newPWD = _newPWDController.text;
    _confirmPWD = _confirmPWDController.text;

    if (_oldPWD.isEmpty || _oldPWD == null) {
      _showToast("原密码不能为空!");
      return false;
    }

    if (_localPWD != _oldPWD) {
      _showToast("原密码不正确，请重新输入!");
      return false;
    }
    if (_newPWD.isEmpty || _newPWD == null) {
      _showToast("新密码不能为空!");
      return false;
    }
    if (_confirmPWD.isEmpty || _confirmPWD == null) {
      _showToast("确认密码不能为空!");
      return false;
    }
    if (_newPWD != _confirmPWD) {
      _showToast("新密码确认错误，请重新输入!");
      return false;
    }

    LoginAPI.login(_user, _oldPWD, funcName: "resetPws", newPwd: _newPWD)
        .then((loginUser) {
      if (loginUser == null) {
        _showToast("网络异常");
        return;
      }
      if (this.mounted) {
        setState(() {
          if (!loginUser.loginUserList[0].isSucess) {
            _showToast(loginUser.loginUserList[0].error);
          } else {
            _writerDataToFile();
            _showToast("密码修改成功!");
          }
        });
      }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            '修改密码',
            style: TextStyle(
                // color: Colors.red,
                ),
          ),
        ),
        body: new SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                  child: TextField(
                    obscureText: oldObscure,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.lock_open),
                      labelText: '原密码',
                      helperText: '请输入您的原密码',
                      suffixIcon: new IconButton(
                        icon: Icon(oldObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        iconSize: 28,
                        onPressed: () async {
                          if (this.mounted) {
                            setState(() {
                              oldObscure = !oldObscure;
                            });
                          }
                        },
                      ),
                    ),
                    controller: _oldPWDController,
                    autofocus: false,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.lock_outline),
                      labelText: '输入新密码',
                      helperText: '请输入您的新密码',
                    ),
                    controller: _newPWDController,
                    obscureText: true,
                    autofocus: false,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.lock),
                      labelText: '确认新密码',
                      helperText: '请再次输入您的新密码',
                    ),
                    controller: _confirmPWDController,
                    obscureText: true,
                  )),
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: SizedBox(
                                width: 30,
                                height: 40,
                                child: new RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "确定",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_changePWD()) {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/my");
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: SizedBox(
                                width: 30,
                                height: 40,
                                child: new RaisedButton(
                                    highlightColor:
                                        Theme.of(context).primaryColor,
                                    child: Text(
                                      "取消",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    textColor: pressDown
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, "/my");
                                    },
                                    onHighlightChanged: (state) {
                                      setState(() {
                                        pressDown = state;
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                        side: new BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          )),
                    ],
                  )),
            ],
          ),
        )));
  }
}

Widget getRaisedButtonIcon(BuildContext context) {
  return RaisedButton.icon(
    icon: Icon(Icons.cancel),
    label: Text("取消"),
    onPressed: () {
      Navigator.popAndPushNamed(context, "/tabs");
    },
    textTheme: ButtonTextTheme.normal,
    textColor: Colors.red,
    disabledTextColor: Colors.red,
    // color: Color(0xFF82B1FF),
    disabledColor: Colors.grey,
    highlightColor: Colors.red,
    colorBrightness: Brightness.light,
    elevation: 10,
    highlightElevation: 10,
    disabledElevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
            color: Color(0xFFF0F00), style: BorderStyle.solid, width: 2)),
    clipBehavior: Clip.antiAlias,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    animationDuration: Duration(seconds: 1),
  );
}

Widget getRaisedButtonIconOK(BuildContext context, event) {
  return RaisedButton.icon(
    icon: Icon(Icons.check),
    label: Text("确定"),
    onPressed: () {
      // _changePWD();
      // event;
    },
    textTheme: ButtonTextTheme.normal,
    textColor: Colors.green,
    disabledTextColor: Colors.green,
    // color: Color(0xFF82B1FF),
    highlightColor: Colors.green,
    colorBrightness: Brightness.light,
    elevation: 10,
    highlightElevation: 10,
    disabledElevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
            color: Colors.grey[200], style: BorderStyle.solid, width: 2)),
    clipBehavior: Clip.antiAlias,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    animationDuration: Duration(seconds: 1),
  );
}
