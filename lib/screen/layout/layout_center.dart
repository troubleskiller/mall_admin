import 'package:flutter/material.dart';
import 'package:flutter_mall_admin/constant/enum.dart';
import 'package:flutter_mall_admin/extension/context_extension.dart';
import 'package:flutter_mall_admin/index_stack_lazy.dart';
import 'package:flutter_mall_admin/model/admin/tabPage_model.dart';
import 'package:flutter_mall_admin/route/routes.dart';
import 'package:flutter_mall_admin/screen/layout/layout_controller.dart';
import 'package:flutter_mall_admin/util/store_util.dart';
import 'package:flutter_mall_admin/util/utils.dart';
import 'package:flutter_mall_admin/widget/menu_widget.dart';
import 'package:provider/provider.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key? key}) : super(key: key);

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends State<LayoutCenter>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMaximize = context.watch<LayoutController>().isMaximize;
    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    if (openedTabPageList.length == 0) {
      return Container();
    }
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    int currentIndex = openedTabPageList
        .indexWhere((note) => note!.id == currentOpenedTabPageId);
    var tabController = TabController(
        vsync: this,
        length: openedTabPageList.length,
        initialIndex: currentIndex);
    var defaultTabs = StoreUtil.getDefaultTabs();

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        StoreUtil.writeCurrentOpenedTabPageId(
            openedTabPageList[tabController.index]!.id);
        setState(() {});
      }
    });

    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: openedTabPageList.map<Tab>((TabPage? tabPage) {
        var tabContent = Row(
          children: <Widget>[
            Text(tabPage!.name ?? ''),
            if (!defaultTabs.contains(tabPage))
              Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: 25,
                  child: IconButton(
                    iconSize: 10,
                    splashRadius: 10,
                    onPressed: () {
                      Utils.closeTab(tabPage);
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              )
          ],
        );
        return Tab(
          child: Menu(
            child: tabContent,
            onSelected: (dynamic v) {
              switch (v) {
                case TabMenuOption.close:
                  Utils.closeTab(tabPage);
                  break;
                case TabMenuOption.closeAll:
                  Utils.closeAllTab();
                  break;
                case TabMenuOption.closeOthers:
                  Utils.closeOtherTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheRight:
                  Utils.closeAllToTheRightTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheLeft:
                  Utils.closeAllToTheLeftTab(tabPage);
                  break;
              }
              setState(() {});
            },
            itemBuilder: (context) => <PopupMenuEntry<TabMenuOption>>[
              if (!defaultTabs.contains(tabPage))
                const PopupMenuItem(
                  value: TabMenuOption.close,
                  child: ListTile(
                    title: Text('Close'),
                  ),
                ),
              const PopupMenuItem(
                value: TabMenuOption.closeAll,
                child: ListTile(
                  title: Text('Close All'),
                ),
              ),
              const PopupMenuItem(
                value: TabMenuOption.closeOthers,
                child: ListTile(
                  title: Text('Close Others'),
                ),
              ),
              const PopupMenuItem(
                value: TabMenuOption.closeAllToTheRight,
                child: ListTile(
                  title: Text('Close All to the Right'),
                ),
              ),
              const PopupMenuItem(
                value: TabMenuOption.closeAllToTheLeft,
                child: ListTile(
                  title: Text('Close All to the Left'),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

    var content = Container(
      child: Expanded(
        child: IndexedStackLazy(
          index: currentIndex,
          children: openedTabPageList.map((TabPage? tabPage) {
            var page = tabPage!.url != null
                ? Routes.layoutPagesMap[tabPage.url!] ?? Container()
                : tabPage.widget ?? Container();
            return KeyedSubtree(
              child: page,
              key: Key('page-${tabPage.id}'),
            );
          }).toList(),
        ),
      ),
    );

    var result = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: context.theme.primaryColor,
            child: Row(
              children: <Widget>[
                Expanded(child: tabBar),
                IconButton(
                  onPressed: () {
                    context.read<LayoutController>().toggleMaximize();
                  },
                  icon: Icon(
                      isMaximize ? Icons.close_fullscreen : Icons.open_in_full),
                  iconSize: 20,
                  color: Colors.white,
                )
              ],
            ),
          ),
          content,
        ],
      ),
    );
    return result;
  }
}
