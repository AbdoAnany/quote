import 'package:firebase_storage/firebase_storage.dart';
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

  Future<String> addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final imagePath = FirebaseStorage.instance.ref('$text').getDownloadURL();
      final imagePath1 = FirebaseStorage.instance.ref().listAll();

      print(imagePath1);

      notifyListeners();
      print(imagePath);

      return imagePath;
    } catch (e) {
      print(e);
    }
    return '0';
  }
}
