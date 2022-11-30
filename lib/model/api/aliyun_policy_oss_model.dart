import 'dart:convert';

/// accessId : "LTAI5t6UQSgT4czqpU9ScnAa"
/// policy : "eyJleHBpcmF0aW9uIjoiMjAyMi0xMS0yOFQwNToxMDoxNi40NjdaIiwiY29uZGl0aW9ucyI6W1siY29udGVudC1sZW5ndGgtcmFuZ2UiLDAsMTA0ODU3NjAwMF0sWyJzdGFydHMtd2l0aCIsIiRrZXkiLCIyMDIyLTExLTI4LyJdXX0="
/// signature : "EkSVRtK3sWgpu5FofTYS1CtCI1A="
/// dir : "2022-11-28/"
/// host : "https://troubleskiller-mall.oss-cn-hangzhou.aliyuncs.com"
/// expire : "1669612216"

AliyunPolicyOssModel aliyunPolicyOssModelFromJson(String str) =>
    AliyunPolicyOssModel.fromJson(json.decode(str));

String aliyunPolicyOssModelToJson(AliyunPolicyOssModel data) =>
    json.encode(data.toJson());

class AliyunPolicyOssModel {
  AliyunPolicyOssModel({
    this.accessId,
    this.policy,
    this.signature,
    this.dir,
    this.host,
    this.expire,
  });

  AliyunPolicyOssModel.fromJson(dynamic json) {
    accessId = json['accessId'];
    policy = json['policy'];
    signature = json['signature'];
    dir = json['dir'];
    host = json['host'];
    expire = json['expire'];
  }

  String? accessId;
  String? policy;
  String? signature;
  String? dir;
  String? host;
  String? expire;

  AliyunPolicyOssModel copyWith({
    String? accessId,
    String? policy,
    String? signature,
    String? dir,
    String? host,
    String? expire,
  }) =>
      AliyunPolicyOssModel(
        accessId: accessId ?? this.accessId,
        policy: policy ?? this.policy,
        signature: signature ?? this.signature,
        dir: dir ?? this.dir,
        host: host ?? this.host,
        expire: expire ?? this.expire,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessId'] = accessId;
    map['policy'] = policy;
    map['signature'] = signature;
    map['dir'] = dir;
    map['host'] = host;
    map['expire'] = expire;
    return map;
  }
}
