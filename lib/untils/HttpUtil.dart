import 'package:dio/dio.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  // static Config _config = new Config();

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    options = BaseOptions(
      baseUrl: "https://www.xx.com/api",
      connectTimeout: 10000,
      receiveTimeout: 3000,
      headers: {},
    );
    dio = new Dio(options);
  }

  get(url, {queryParameters, options, cancelToken}) async {
    Response response;
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
    print(response.statusCode);
    print(response.statusMessage);
    return response.data;
  }

  post(url, {data, options, cancelToken}) async {
    Response response;
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
    return response.data;
  }
}
