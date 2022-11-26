import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/util/api/http_util.dart';

class BrandApi {
  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi =
        await HttpUtil.post('/product/brand/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi =
        await HttpUtil.post('/product/brand/save', data: data);
    return responseBodyApi;
  }

  static removeByIds(data) {
    return HttpUtil.post('/product/brand/delete', data: data);
  }
}
