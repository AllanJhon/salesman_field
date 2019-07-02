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
      headers: {},
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
    }
    return response.data;
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
    }
    return response;
  }
}
