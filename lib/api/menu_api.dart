import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/util/api/http_util.dart';

class MenuApi {
  static Future<ResponseBodyApi> listAuth(data) async {
    return await HttpUtil.post('/admin/menu/listAuth', data: data);
  }

  static Future<ResponseBodyApi> list() async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post(
      '/admin/menu/list',
    );
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi =
        await HttpUtil.post('/admin/menu/saveOrUpdate', data: data);
    return responseBodyApi;
  }

  static removeByIds(data) {
    return HttpUtil.post('/admin/menu/removeByIds', data: data);
  }
}
