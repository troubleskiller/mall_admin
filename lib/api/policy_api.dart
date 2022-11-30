import 'package:dio/dio.dart';
import 'package:flutter_mall_admin/model/api/aliyun_policy_oss_model.dart';
import 'package:flutter_mall_admin/model/api/response_api.dart';
import 'package:flutter_mall_admin/util/api/http_util.dart';

class PolicyApi {
  static Future<ResponseBodyApi> getPolicy() async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/third/oss/policy');
    return responseBodyApi;
  }

  static ossUpload(AliyunPolicyOssModel policy, file) async {
    Dio dio = Dio();
    var filename = file.filename;

    // 签名
    FormData data = new FormData.fromMap({
      'Filename': '文件名，随意',
      'key': '${policy.dir}$filename',
      'policy': policy.policy,
      'OSSAccessKeyId': policy.accessId,
      'success_action_status': '200', //让服务端返回200，不然，默认会返回204
      'signature': policy.signature,
      'dir': policy.dir,
      'host': policy.host,
      'file': file,
    });

    try {
      Response response = await dio.post(
          'https://troubleskiller-mall.oss-cn-hangzhou.aliyuncs.com',
          data: data);
      var uploadPath =
          "'https://troubleskiller-mall.oss-cn-hangzhou.aliyuncs.com'/$filename";
      print("上传成功: $uploadPath");
      return response;
    } on DioError catch (e) {
      print("上传失败: $e");
    }
  }
}
