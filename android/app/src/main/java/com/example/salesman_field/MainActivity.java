package com.example.salesman_field;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.util.Log;  
import android.net.Uri;
import java.io.File;
import android.content.Intent; 
import android.content.ContentProvider;
import android.app.Activity;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.example.salesman_field";

  @Override
  protected void onCreate(Bundle savedInstanceState) { 
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                      // Log.v("TAG", "currentX=" + "X");   
                        // TODO
                        if (call.method.equals("install")) {
                          String path = call.argument("path").toString();
                          System.out.println(android.os.Build.VERSION.SDK_INT);

                        int batteryLevel = install(path);
                        if (batteryLevel != -1) {
                            result.success(batteryLevel);
                        } 
                        } 
                    }
                });
  }

  //高于android 8.0以上的，还没测试通过
  private int install(String path){
    Uri uri;
    Intent intent = new Intent(Intent.ACTION_VIEW);
    File file = new File(path);
    // if (android.os.Build.VERSION.SDK_INT >=24) {//android 7.0以上
    //    uri = FileProvider.getUriForFile(this, BuildConfig.APPLICATION_ID.concat(".provider"), file);
    // } else{
    //    uri = Uri.fromFile(file);
    // }
    uri = Uri.fromFile(file);
    String type = "application/vnd.android.package-archive";
    intent.setDataAndType(uri, type);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    if (android.os.Build.VERSION.SDK_INT >= 24) {
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    }
    startActivityForResult(intent, 10);

    System.out.println("....................install");
    return 1;
  }
}
