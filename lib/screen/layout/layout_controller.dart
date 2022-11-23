import 'package:flutter/cupertino.dart';
import 'package:flutter_mall_admin/constant/enum.dart';

class LayoutController extends ChangeNotifier {
  MenuDisplayType? menuDisplayType = MenuDisplayType.side;
  bool isMaximize = false;

  toggleMaximize() {
    isMaximize = !isMaximize;
    notifyListeners();
  }

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
