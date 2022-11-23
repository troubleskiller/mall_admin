import 'package:dio/dio.dart';
import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/model/application/properties.dart';
import 'package:flutter_mall_admin/util/tro_util.dart';

class HttpUtil {
  static Dio? dio;
  static const String POST = 'post';
  static const String GET = 'get';

  static Future<ResponseBodyApi> get(String url,
      {data, requestToken = true}) async {
    return await request(url,
        data: data, requestToken: requestToken, method: GET);
  }

  static Future<ResponseBodyApi> post(String url,
      {data, requestToken = true}) async {
    return await request(url, data: data, requestToken: requestToken);
  }

  static Future<ResponseBodyApi> request(String url,
      {data, method, requestToken = true}) async {
    data = data ?? {};
    method = method ?? POST;

    Dio dio = createInstance()!;
    dio.options.method = method;

    ResponseBodyApi responseBodyApi;
    try {
      Response res = await dio.request(url, data: data);
      print(res.toString());
      responseBodyApi = ResponseBodyApi.fromJson(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi();
    }

    return responseBodyApi;
  }

  static Dio? createInstance() {
    if (dio == null) {
      TroProperties troProperties = TroUtils.getTroProperties();
      var apiProperties = troProperties.apiProperties;
      BaseOptions options = BaseOptions(
          baseUrl: apiProperties.baseUrl!,
          connectTimeout: apiProperties.connectTimeout,
          receiveTimeout: apiProperties.receiveTimeout,
          headers: {
            "Content-Type": "application/json",
            "User-Agent": "Mozilla 5.10", // 这里的设置是必须的必
            "USERNAME": "SANDBOX",
          });

      dio = Dio(options);
    }

    return dio;
  }

  static clear() {
    dio = null;
  }
}
