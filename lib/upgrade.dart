import 'dart:async' as prefix0;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';

var downLoadUrl = "http://10.0.65.48:8287";
var msg = "无信息";
PackageInfo packageInfo;
var _localVersion = "0.0";
var _lastVersion = "0.1";
bool ifUpdate;

class Upgrade extends StatefulWidget {
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localVersion = "";
    _lastVersion = "";
    checkNewVersion();
  }

  run() async {
    // bool ifUpdate = await checkNewVersion();
    setState(() {
      msg = ifUpdate ? "更新版本：$_localVersion-->$_lastVersion" : "当前已是最新版本";
      if (ifUpdate) {
        print("要更新版本了");
        // executeDownload();
      }
    });
  }

  getLastVersion() async {
    try {
      final res = await http.get(downLoadUrl + '/version.json');
      if (res.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(res.body);
        return body['android'];
      }
    } catch (e) {
      return '0.0';
    }
  }

  getLoacalVersion() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    }
  }

  checkNewVersion<bool>() async {
    _lastVersion = await getLastVersion();
    _localVersion = await getLoacalVersion();
    ifUpdate = (_lastVersion.compareTo(_localVersion) == 1);
    setState(() {
      msg = ifUpdate ? "更新版本：$_localVersion-->$_lastVersion" : "当前已是最新版本";
    });
    return (_localVersion.compareTo(_lastVersion) == 1);
  }

  Future<String> get _apkLocalPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

// 下载
  Future<void> executeDownload() async {
    if (!ifUpdate) return;
    final path = await _apkLocalPath;
    print("........................开始下载$path");
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: downLoadUrl + '/app-release.apk',
        savedDir: path,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        print("........................下载完毕$status");
        _installApk();
      }
    });
  }

// 安装
  Future<Null> _installApk() async {
    const platform = const MethodChannel("com.example.salesman_field");
    try {
      final path = await _apkLocalPath;
      // 调用app地址
      await platform
          .invokeMethod('install', {'path': path + '/app-release.apk'});
      print(platform.toString());
    } on PlatformException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          '版本更新',
        ),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            new Container(
              child: Text(
                msg,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: new RaisedButton(
                      // color: Colors.green,
                      color: Colors.greenAccent[700],
                      splashColor: Colors.black,
                      highlightColor: Colors.lightBlue[900],
                      child: Text(
                        "升级新版本",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        ifUpdate?executeDownload():Null;
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
            ),
          ],
        ),
      ),
    );
  }
}
