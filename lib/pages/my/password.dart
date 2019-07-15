import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';

var _oldPWDController = TextEditingController();
var _newPWDController = TextEditingController();
var _confirmPWDController = TextEditingController();
var _oldPWD;
var _newPWD;
var _confirmPWD;
var _user;
var _localPWD;
var _md5PWD;

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  void initState() {
    super.initState();
    _readLoginData().then((Map onValue) {
      setState(() {
        _user = onValue["user"];
        _localPWD = onValue["pwd"];
        // _md5PWD = onValue["md5PWD"];
      });
    });
  }

  Future<Map> _readLoginData() async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/login.txt');
      String data = await file.readAsString();
      Map json = new JsonDecoder().convert(data);
      return json;
    } on FileSystemException {
      return new JsonDecoder()
          .convert('{"user":"error","pwd":"error","md5PWD":"error"}');
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

  //写数据
  Future<Null> _writerDataToFile() async {
    var confirmPWD = _confirmPWDController.text;
    confirmPWD = md5.convert(utf8.encode(confirmPWD)).toString();
    await (await _getLocalFile()).writeAsString(
        '{"user":"$_user","pwd":"$_newPWD","md5PWD":"$_md5PWD"}');
  }

  bool _changePWD() {
    _oldPWD = _oldPWDController.text;
    _newPWD = _newPWDController.text;
    _confirmPWD = _confirmPWDController.text;

    if (_oldPWD.isEmpty || _oldPWD == null) {
      _showToast("原密码不能为空!");
      return false;
    }
    //判断原密码和现在输入的是否一致，暂定在本机判断
    _md5PWD = md5.convert(utf8.encode(_oldPWD)).toString();
    print("_localPWD = $_localPWD   _oldPWD=$_oldPWD");
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

    // 缺少一个提交服务端的过程

    // 服务端提交成功后，写本地
    _writerDataToFile();
    _showToast("密码修改成功!");
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
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.lock_open),
                      labelText: '原密码',
                      helperText: '请输入您的原密码',
                    ),
                    controller: _oldPWDController,
                    autofocus: false,
                    obscureText: true,
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
                                    color: Colors.green,
                                    highlightColor: Colors.green[900],
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
                                    color: Colors.red[400],
                                    highlightColor: Colors.red[900],
                                    child: Text(
                                      "取消",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, "/my");
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          )),
                    ],
                  )),
              // SizedBox(height: 20),
              // Padding(
              //     padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              //     child: Row(
              //       children: <Widget>[
              //         Expanded(
              //           flex: 1,
              //           child: Padding(
              //             padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //             child: SizedBox(
              //               width: 30,
              //               height: 40,
              //               child: getRaisedButtonIconOK(context, "_changePWD()"),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           flex: 1,
              //           child: Padding(
              //             padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //             child: SizedBox(
              //               width: 30,
              //               height: 40,
              //               child: getRaisedButtonIcon(context),
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),
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
