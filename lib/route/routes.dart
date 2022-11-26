/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:
import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/model/admin/tabPage_model.dart';
import 'package:flutter_mall_admin/screen/brand_screen.dart';
import 'package:flutter_mall_admin/screen/category_screen/category_list.dart';
import 'package:flutter_mall_admin/screen/layout/layout.dart';

class Routes {
  // static List<GetPage>? pages;

  static Map<String, Widget> layoutPagesMap = {
    '/': Layout(),
    // '/dashboard': Dashboard(),
    // '/sAreaAgeGenderMain': SAreaAgeGenderMain(),
    // '/roleList': RoleList(),
    // '/personList': PersonList(),
    // '/menuList': MenuMain(),
    // '/userInfoList': UserInfoList(),
    // '/deptMain': DeptMain(),
    // '/imageUpload': ImageUpload(),
    // '/videoUpload': VideoUpload(),
    '/product/brand': BrandList(),
    '/product/category': CategoryList(),
    // '/layout401': Page401(),
    // '/layout404': Page404(),
    // '/layoutTest': MyTest(1),
    // '/dictList': DictList(),
    // '/message': MessageMain(),
    // '/subsystemList': SubsystemMain(),
    // '/settingBase': SettingBase(),
    // '/secondLevel': SecondList(),
    // '/threeLevel': OnlyText('三级菜单页面'),
  };
  static List<String> whiteRoutes = ['/register'];

  static List<TabPage> otherTabPage = [
    TabPage(id: 0, url: '/userInfoMine', name: '我的信息', nameEn: 'My Info'),
    TabPage(id: 200, url: '/message', name: '反馈', nameEn: 'Feedback'),
  ];

  // static init() {
  //   List<GetPage> layoutPages = layoutPagesMap.entries
  //       .map((e) => GetPage(name: e.key, page: () => e.value))
  //       .toList();
  //   pages = [
  //     GetPage(
  //       name: '/login',
  //       page: () => Login(),
  //     ),
  //     GetPage(
  //       name: '/',
  //       page: () => Layout(),
  //       middlewares: [AuthMiddleware()],
  //     ),
  //     GetPage(
  //       name: '/layout',
  //       page: () => Layout(),
  //       middlewares: [AuthMiddleware()],
  //       children: layoutPages,
  //     ),
  //   ];
  // }
}

// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     return Utils.isLogin() ? null : RouteSettings(name: '/login');
//   }
// }
