import 'package:flutter_mall_admin/model/admin/tabPage_model.dart';
import 'package:flutter_mall_admin/model/admin/treeVo.dart';

class MenuModel extends TreeData {
  MenuModel({
    this.id,
    this.name,
    this.nameEn,
    this.icon,
    this.pid,
    this.url,
    this.module,
    this.remark,
    this.createTime,
    this.updateTime,
    this.orderBy,
    this.subsystemId,
  }) : super(id, pid);

  factory MenuModel.fromJson(dynamic json) {
    return MenuModel(
      id: int.parse(json['id']),
      name: json['name'],
      nameEn: json['nameEn'],
      icon: json['icon'],
      pid: int.parse(json['pid']),
      url: json['url'],
      module: json['module'],
      remark: json['remark'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      orderBy: json['orderBy'],
      subsystemId: json['subsystemId'],
    );
  }

  int? id;
  String? name;
  String? nameEn;
  dynamic icon;
  int? pid;
  String? url;
  dynamic module;
  String? remark;
  String? createTime;
  String? updateTime;
  int? orderBy;
  String? subsystemId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['nameEn'] = nameEn;
    map['icon'] = icon;
    map['pid'] = pid;
    map['url'] = url;
    map['module'] = module;
    map['remark'] = remark;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    map['orderBy'] = orderBy;
    map['subsystemId'] = subsystemId;
    return map;
  }

  toTabPage() {
    return TabPage(
      id: id,
      name: name,
      nameEn: nameEn,
      url: url,
    );
  }
}
