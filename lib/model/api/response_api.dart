class ResponseBodyApi<T> {
  ResponseBodyApi({
    this.code,
    this.data,
  });

  ResponseBodyApi.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'];
  }
  int? code;
  T? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['data'] = data;
    return map;
  }

  @override
  String toString() {
    return 'ResponseBodyApi{code: $code, data: $data}';
  }
}
