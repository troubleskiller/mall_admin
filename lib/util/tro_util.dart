/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/cry、https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:
import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/context/application_context.dart';
import 'package:flutter_mall_admin/model/application/tro_properties.dart';

class TroUtils {
  static OverlayEntry? loadingOE;

  static TroProperties getTroProperties() {
    TroProperties troProperties =
        ApplicationContext.instance.getBean('troProperties');
    return troProperties;
  }
}
