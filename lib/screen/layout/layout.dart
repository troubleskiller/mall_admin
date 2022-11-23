import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/model/admin/menu_model.dart';
import 'package:flutter_mall_admin/screen/layout/layout_center.dart';
import 'package:flutter_mall_admin/screen/layout/layout_controller.dart';
import 'package:flutter_mall_admin/screen/layout/layout_menu.dart';
import 'package:flutter_mall_admin/util/utils.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final GlobalKey<LayoutCenterState> layoutCenterKey =
      GlobalKey<LayoutCenterState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var layoutMenu = LayoutMenu(onClick: (MenuModel menu) {
      Utils.openTab(menu.id!);
      setState(() {});
    });
    var controller = context.watch<LayoutController>();
    var body = Utils.isMenuDisplayTypeDrawer(context) || controller.isMaximize
        ? Row(children: [LayoutCenter(key: layoutCenterKey)])
        : Row(
            children: <Widget>[
              layoutMenu,
              VerticalDivider(
                width: 2,
                color: Colors.black12,
                thickness: 2,
              ),
              LayoutCenter(key: layoutCenterKey),
            ],
          );
    Scaffold subWidget = controller.isMaximize
        ? Scaffold(body: body)
        : Scaffold(
            key: scaffoldStateKey,
            drawer: layoutMenu,
            // endDrawer: LayoutSetting(),
            body: body,
            // appBar: getAppBar(),
          );
    return subWidget;
  }
  // getAppBar() {
  //   var userInfo = StoreUtil.getCurrentUserInfo();
  //   var subsystemList = StoreUtil.getSubsystemList();
  //   var currentSubsystem = StoreUtil.getCurrentSubsystem();
  //   return AppBar(
  //     backgroundColor: context.theme.primaryColor,
  //     automaticallyImplyLeading: false,
  //     leading: !Utils.isMenuDisplayTypeDrawer(context)
  //         ? Tooltip(
  //         message: 'Home',
  //         child: IconButton(
  //           icon: Icon(Icons.home),
  //           onPressed: () {
  //             Utils.launchURL('http://www.cairuoyu.com');
  //           },
  //         ))
  //         : Tooltip(
  //         message: 'Menu',
  //         child: IconButton(
  //           icon: Icon(Icons.menu),
  //           onPressed: () {
  //             scaffoldStateKey.currentState!.openDrawer();
  //           },
  //         )),
  //     title: Row(children: [
  //       Text(currentSubsystem?.name ?? '--'),
  //       PopupMenuButton(
  //           tooltip: '选择子系统',
  //           onSelected: (String v) async {
  //             var subsystem = subsystemList.firstWhere((element) => element.id == v);
  //             StoreUtil.write(Constant.KEY_CURRENT_SUBSYSTEM, subsystem.toMap());
  //             await StoreUtil.loadMenuData();
  //             StoreUtil.init();
  //             setState(() {});
  //           },
  //           itemBuilder: (context) => subsystemList.map<PopupMenuEntry<String>>(
  //                 (e) {
  //               var enabled = e.id != currentSubsystem?.id;
  //
  //               return PopupMenuItem<String>(
  //                 enabled: enabled,
  //                 value: e.id,
  //                 child: ListTile(
  //                   title: Text(
  //                     e.name ?? '--',
  //                     style: TextStyle(color: enabled ? null : Colors.black12),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ).toList()),
  //     ]),
  //     actions: <Widget>[
  //       Tooltip(
  //         message: 'Setting',
  //         child: IconButton(
  //           icon: Icon(Icons.settings),
  //           onPressed: () {
  //             scaffoldStateKey.currentState!.openEndDrawer();
  //           },
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: PopupMenuButton(
  //           tooltip: userInfo.userName,
  //           onSelected: (dynamic v) {
  //             if (v == 'info') {
  //               Utils.openTab('userInfoMine');
  //             } else if (v == 'logout') {
  //               Utils.logout();
  //               Cry.pushNamedAndRemove('/login');
  //             }
  //           },
  //           child: Align(
  //             child: userInfo.avatarUrl == null
  //                 ? Icon(Icons.person)
  //                 : CircleAvatar(
  //               backgroundImage: NetworkImage(userInfo.avatarUrl!),
  //               radius: 12.0,
  //             ),
  //           ),
  //           itemBuilder: (context) => <PopupMenuEntry<String>>[
  //             PopupMenuItem<String>(
  //               value: 'info',
  //               child: ListTile(
  //                 leading: const Icon(Icons.info),
  //                 title: Text(S.of(context).myInformation),
  //               ),
  //             ),
  //             const PopupMenuDivider(),
  //             PopupMenuItem<String>(
  //               value: 'logout',
  //               child: ListTile(
  //                 leading: const Icon(Icons.logout),
  //                 title: Text(S.of(context).logout),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       PopupMenuButton(
  //         onSelected: (dynamic v) {
  //           switch (v) {
  //             case 'code':
  //               Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
  //               break;
  //             case 'android':
  //               var about = Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Image.asset(
  //                     'assets/images/app_download.png',
  //                     width: 150,
  //                   ),
  //                   SizedBox(height: 20),
  //                   CryButton(
  //                     label: '下载apk',
  //                     onPressed: () {
  //                       Utils.launchURL("http://www.cairuoyu.com/f/lib/app.apk");
  //                     },
  //                   ),
  //                 ],
  //               );
  //               cryAlertWidget(context, about);
  //               break;
  //             case 'about':
  //               var about = Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Author：CaiRuoyu'),
  //                   SizedBox(height: 20),
  //                   Text('Github：https://github.com/cairuoyu/flutter_admin'),
  //                   SizedBox(height: 20),
  //                   Text('Flutter admin版本：1.4.0'),
  //                   SizedBox(height: 20),
  //                   Text('Flutter SDK版本：stable, 2.5.1'),
  //                 ],
  //               );
  //               cryAlertWidget(context, about);
  //               break;
  //             case 'feedback':
  //               Utils.openTab('message');
  //               break;
  //             case 'privacy':
  //               var privacy = ApplicationContext.instance.privacy;
  //               cryAlert(context, privacy);
  //               break;
  //           }
  //         },
  //         itemBuilder: (context) => <PopupMenuEntry<String>>[
  //           PopupMenuItem<String>(
  //             value: 'code',
  //             child: ListTile(
  //               leading: const Icon(Icons.code),
  //               title: Text('源码'),
  //             ),
  //           ),
  //           const PopupMenuDivider(),
  //           PopupMenuItem<String>(
  //             value: 'android',
  //             child: ListTile(
  //               leading: const Icon(Icons.android),
  //               title: Text('android'),
  //             ),
  //           ),
  //           const PopupMenuDivider(),
  //           PopupMenuItem<String>(
  //             value: 'feedback',
  //             child: ListTile(
  //               leading: const Icon(Icons.feedback),
  //               title: Text('反馈'),
  //             ),
  //           ),
  //           const PopupMenuDivider(),
  //           PopupMenuItem<String>(
  //             value: 'about',
  //             child: ListTile(
  //               leading: const Icon(Icons.vertical_split),
  //               title: Text('关于'),
  //             ),
  //           ),
  //           const PopupMenuDivider(),
  //           PopupMenuItem<String>(
  //             value: 'privacy',
  //             child: ListTile(
  //               leading: const Icon(Icons.privacy_tip),
  //               title: Text('隐私'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
