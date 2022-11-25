import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/util/api/http_util.dart';

class UserApi {
  static Future<ResponseBodyApi> register(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post(
        '/admin/user/register',
        data: data,
        requestToken: false);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> login(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/admin/user/login',
        data: data, requestToken: false);
    return responseBodyApi;
  }
}
