import 'package:flutter/material.dart';

import 'models/product_item.dart';

enum preferences { SystemPreference, Light, Dark }

class UserPreference with ChangeNotifier {
  bool systemPreferenceSwitch = true;
  bool lightSwitch = false;
  bool darkSwitch = false;
  late ThemeMode themeMode;
  String heroTag = "anime0";
  String heroTag1 = "name0";
  String heroTag2 = "animename0";
  ProductItem productItem = products[0];
}
