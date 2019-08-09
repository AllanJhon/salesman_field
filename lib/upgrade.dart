import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:salesman_field/models/versionModel.dart';
import 'dart:async';
import 'data/SAPCONST.dart';
import 'service/versionAPI.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

var msg = "未获取到新版本信息";
PackageInfo packageInfo;
var _localVersion = "1.0";
var _lastVersion = "1.0";
bool ifUpdate = false;
bool _loading = false;
Version _version;
const APKNAME = 'jyjdsales.apk';
ProgressDialog pr;

class Upgrade extends StatefulWidget {
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context, ProgressDialogType.Download);
    _localVersion = "";
    _lastVersion = "";
    _loading = true;
    checkNewVersion1();
  }

  //原读取版本信息接口
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

  //变更读取最新版本接口
  checkNewVersion1() async {
    _localVersion = await getLoacalVersion();
    VersionAPI.getVersion().then((version) {
      setState(() {
        _version = version;
        _lastVersion = version == null ? '0.0' : version.versionCode;
        ifUpdate = (_lastVersion.compareTo(_localVersion) == 1);
        var t = version.content;
        msg = ifUpdate
            ? '''更新版本：$_localVersion-->$_lastVersion '''
            : "当前已是最新版本:V$_localVersion";
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

  /* 
  checkNewVersion<bool>() async {
    _lastVersion = getLastVersion();
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
*/
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
        url: getSelfURL() + _version.updateFile,
        savedDir: path,
        fileName: APKNAME,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      if (!pr.isShowing()) {
        pr.show();
      }
      if (status == DownloadTaskStatus.running) {
        pr.update(progress: progress.toDouble(), message: "下载中，请稍后…");
      }

      if (status == DownloadTaskStatus.failed) {
        _showToast("下载异常，请稍后重试");
        if (pr.isShowing()) {
          pr.hide();
        }
      }
      if (taskId == id && status == DownloadTaskStatus.complete) {
        if (pr.isShowing()) {
          pr.hide();
        }
        // _installApk();
        FlutterDownloader.open(taskId: taskId);
      }
    });
  }

// 安装
  Future<Null> _installApk() async {
    const platform = const MethodChannel("com.example.salesman_field");
    try {
      final path = await _apkLocalPath;
      // 调用app地址
      await platform.invokeMethod('install', {'path': '$path/$APKNAME'});
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
            ? Center(
                child: Text("正在加载..."),
              )
            // ProgressDialog(
            //     loading: _loading,
            //     msg: '正在加载...',
            //     child: Center(),
            //   )
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
                            color: Theme.of(context).primaryColor,
                            disabledColor: Colors.grey,
                            splashColor: Colors.black,
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
