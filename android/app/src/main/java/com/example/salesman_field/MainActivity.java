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
import android.app.Activity;
import androidx.core.content.FileProvider;

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
                        int resultInstall = install(path);
                        if (resultInstall != -1) {
                            result.success(resultInstall);
                        } 
                        } 
                    }
                });
  }


  private int install(String path){
    Uri uri;
    Intent intent = new Intent(Intent.ACTION_VIEW);
    File apkFile = new File(path);
    String type = "application/vnd.android.package-archive";
    uri = Uri.fromFile(apkFile);

    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

    if (android.os.Build.VERSION.SDK_INT >= 24) {
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        // Uri uri7 = android.support.v4.content.FileProvider.getUriForFile(GlobalContext.getInstance().context, GlobalContext.getInstance().context.getPackageName() + ".android7.fileprovider", apkFile);  
	       Uri uri7 = androidx.core.content.FileProvider.getUriForFile(this,"com.example.salesman_field.android7.fileprovider", apkFile);  
        intent.setDataAndType(uri7, type);
    } else{
        intent.setDataAndType(uri, type);
    }
    
    startActivityForResult(intent, 10);
    return 1;
  }
}
