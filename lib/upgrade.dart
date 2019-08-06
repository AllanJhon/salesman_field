import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'untils/ProgressDialog.dart';
import 'data/SAPCONST.dart';
import 'service/versionAPI.dart';

var msg = "无信息";
PackageInfo packageInfo;
var _localVersion = "1.0";
var _lastVersion = "1.0";
bool ifUpdate = false;
bool _loading = false;

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
    _loading = true;
    checkNewVersion();
  }

  getLastVersion() async {
    try {
      final res = await http.get(getSelfURL() + '/upgrade/version.json');
      if (res.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(res.body);
        return body['android'];
      }
    } catch (e) {
      return '0.0';
    }
  }

  getLastVersion1() async {
    VersionAPI.getVersion().then((map) {
      setState(() {
        print(map);
        _loading = false;
      });
    });
  }

  //此处用的是versionName比较，
  getLoacalVersion() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    }
  }

  checkNewVersion<bool>() async {
    _loading = true;
    _lastVersion = await getLastVersion1();
    _localVersion = await getLoacalVersion();
    ifUpdate = (_lastVersion.compareTo(_localVersion) == 1);
    setState(() {
      msg = ifUpdate
          ? "更新版本：$_localVersion-->$_lastVersion"
          : "当前已是最新版本:V$_localVersion";
    });
    _loading = false;
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
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: getSelfURL() + '/upgrade/app-release.apk',
        savedDir: path,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
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
        child: _loading
            ? ProgressDialog(
                loading: _loading,
                msg: '正在加载...',
                child: Center(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  new Container(
                    child: Text(
                      msg,
                      style: TextStyle(
                          fontSize: 18, color: Theme.of(context).primaryColor),
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
                            color: Theme.of(context).primaryColor,
                            disabledColor: Colors.grey,
                            splashColor: Colors.black,
                            // highlightColor: Colors.lightBlue[900],
                            child: Text(
                              "升级新版本",
                              style: TextStyle(fontSize: 18),
                            ),
                            textColor: Colors.white,
                            onPressed:
                                ifUpdate ? () => executeDownload() : null,
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)))),
                  ),
                ],
              ),
      ),
    );
  }
}
