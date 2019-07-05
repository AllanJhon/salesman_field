import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  Future<bool> networkCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  HttpUtil() {
    options = BaseOptions(
      baseUrl: "https://www.jdsn.com.cn",
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers: {
        "Content-Type": "text/xml;charset=UTF-8",
        "cache-control": "no-cache",
        "SOAPAction":
            "urn:sap-com:document:sap:rfc:functions:Zif_WQ_IN_WS:ZIF_WQ_IN_WSRequest",
        "Authorization": "Basic VFJGQzAxOjEyMzQ1Ng==",
      },
    );
    dio = new Dio(options);
  }

  get(url, {queryParameters, options, cancelToken}) async {
    Response response;
    if (!await networkCheck()) {
      return "{网络尚未连接}";
    }
    try {
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
      print("e.response.data............" + e.response.data);
      print("e.response.headers............" + e.response.headers.toString());
      print("e.response.request............" + e.response.request.toString());
    }
    return response;
  }

  post(url, {data, options, cancelToken}) async {
    Response response;
    if (!await networkCheck()) {
      return "{网络尚未连接}";
    }
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
      print("e.response.data............" + e.response.data);
      print("e.response.headers............" + e.response.headers.toString());
      print("e.response.request............" + e.response.request.toString());
      print("e.request............" );
      print(e.request.uri);
      print("e.response............" + e.response.toString());
    }
    return response;
  }
}
