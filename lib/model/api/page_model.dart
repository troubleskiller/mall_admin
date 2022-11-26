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
    List<OrderItemModel>? orders,
  }) {
    _orders = orders;
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
  List<OrderItemModel>? _orders;
  List<Map<String, dynamic>>? _records;
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

  set totalCount(int? value) {
    _totalCount = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = _totalCount;
    map['pageSize'] = _pageSize;
    map['totalPage'] = _totalPage;
    map['currPage'] = _currPage;
    map['list'] = _list;
    return map;
  }

  @override
  String toString() {
    return 'PageModel{_orders: $_orders, _records: $_records, _totalCount: $_totalCount, _pageSize: $_pageSize, _totalPage: $_totalPage, _currPage: $_currPage, _list: $_list}';
  }

  set pageSize(int? value) {
    _pageSize = value;
  }

  set totalPage(int? value) {
    _totalPage = value;
  }

  set currPage(int? value) {
    _currPage = value;
  }

  set list(dynamic value) {
    _list = value;
  }

  List<OrderItemModel>? get orders => _orders;

  set orders(List<OrderItemModel>? value) {
    _orders = value;
  }
}

class OrderItemModel {
  String? column;
  bool? asc;
  OrderItemModel({
    this.column,
    this.asc,
  });

  OrderItemModel copyWith({
    String? column,
    bool? asc,
  }) {
    return OrderItemModel(
      column: column ?? this.column,
      asc: asc ?? this.asc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'column': column,
      'asc': asc,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      column: map['column'],
      asc: map['asc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'OrderItemModel(column: $column, asc: $asc)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OrderItemModel && o.column == column && o.asc == asc;
  }

  @override
  int get hashCode => column.hashCode ^ asc.hashCode;
}
