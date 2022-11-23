import 'dart:convert';

/// totalCount : 0
/// pageSize : 10
/// totalPage : 0
/// currPage : 1
/// list : [{"id":"db288d951c390afb08c8341088bd90fa","userName":"admin","password":"admin","createTime":"2020-08-20T02:39:35.000+00:00","updateTime":null,"face":null}]

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));
String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  PageModel({
    int? totalCount,
    int? pageSize,
    int? totalPage,
    int? currPage,
    dynamic list,
  }) {
    _totalCount = totalCount;
    _pageSize = pageSize;
    _totalPage = totalPage;
    _currPage = currPage;
    _list = list;
  }

  PageModel.fromJson(dynamic json) {
    _totalCount = json['totalCount'];
    _pageSize = json['pageSize'];
    _totalPage = json['totalPage'];
    _currPage = json['currPage'];
    _list = json['list'];
  }
  int? _totalCount;
  int? _pageSize;
  int? _totalPage;
  int? _currPage;
  dynamic _list;
  PageModel copyWith({
    int? totalCount,
    int? pageSize,
    int? totalPage,
    int? currPage,
    dynamic list,
  }) =>
      PageModel(
        totalCount: totalCount ?? _totalCount,
        pageSize: pageSize ?? _pageSize,
        totalPage: totalPage ?? _totalPage,
        currPage: currPage ?? _currPage,
        list: list ?? _list,
      );
  int? get totalCount => _totalCount;
  int? get pageSize => _pageSize;
  int? get totalPage => _totalPage;
  int? get currPage => _currPage;
  dynamic get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = _totalCount;
    map['pageSize'] = _pageSize;
    map['totalPage'] = _totalPage;
    map['currPage'] = _currPage;
    map['list'] = _list;
    return map;
  }
}

/// id : "db288d951c390afb08c8341088bd90fa"
/// userName : "admin"
/// password : "admin"
/// createTime : "2020-08-20T02:39:35.000+00:00"
/// updateTime : null
/// face : null

PageList FromJson(String str) => PageList.fromJson(json.decode(str));
String listToJson(PageList data) => json.encode(data.toJson());

class PageList {
  PageList({
    String? id,
    String? userName,
    String? password,
    String? createTime,
    dynamic updateTime,
    dynamic face,
  }) {
    _id = id;
    _userName = userName;
    _password = password;
    _createTime = createTime;
    _updateTime = updateTime;
    _face = face;
  }

  PageList.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['userName'];
    _password = json['password'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _face = json['face'];
  }
  String? _id;
  String? _userName;
  String? _password;
  String? _createTime;
  dynamic _updateTime;
  dynamic _face;
  PageList copyWith({
    String? id,
    String? userName,
    String? password,
    String? createTime,
    dynamic updateTime,
    dynamic face,
  }) =>
      PageList(
        id: id ?? _id,
        userName: userName ?? _userName,
        password: password ?? _password,
        createTime: createTime ?? _createTime,
        updateTime: updateTime ?? _updateTime,
        face: face ?? _face,
      );
  String? get id => _id;
  String? get userName => _userName;
  String? get password => _password;
  String? get createTime => _createTime;
  dynamic get updateTime => _updateTime;
  dynamic get face => _face;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userName'] = _userName;
    map['password'] = _password;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['face'] = _face;
    return map;
  }
}
