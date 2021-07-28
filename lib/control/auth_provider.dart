import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:quote/components/utils.dart';
import 'package:quote/models/product_item.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:permission_handler/permission_handler.dart';

var userid;
var type = 'customer';

List borderList = [];
String imagePath = '';

class AuthProvider with ChangeNotifier {
  late ProductItem _productItem;

  void productItemSet(ProductItem value) {
    _productItem = value;
    notifyListeners();
  }

  ProductItem get productItem => _productItem;
  late GlobalKey key;
  late Uint8List bytes;
  late Database _db;
  static final AuthProvider _instance = AuthProvider.internal();
  factory AuthProvider() => _instance;
  AuthProvider.internal();
  // _requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();
  //
  //   final info = statuses[Permission.storage].toString();
  //   print(info);
  //   _toastInfo(info);
  // }
 Future<bool> screenShot()async{


    bytes = await Utils.capture(key);

    final success = await ImageGallerySaver.saveImage(
      bytes,
      isReturnImagePathOfIOS: true,
    );

    return success['isSuccess'];
    notifyListeners();
  }

  Future<void> borderLists() async {
    var c = await FirebaseFirestore.instance.collection('image').get();
    borderList = c.docs[0]['borderList'];
    notifyListeners();
  }

  _createDatabase() async {
    //
    // if (join(await getDatabasesPath(), 'q.db').isNotEmpty) return _db;
    try {
      if (_db != (null))
        return _db;
      else {
        String path = join(await getDatabasesPath(), 'q.db');
        _db = await openDatabase(path, version: 1,
            onCreate: (Database db, int v) async {
          await db.execute('CREATE TABLE q1 ('
              'id INTEGER PRIMARY KEY,'
              'title varchar(100),'
              'type varchar(100),'
              'data varchar(100) ,'
              'saved INTEGER ,'
              'description varchar(500),'
              'color INTEGER,'
              'image varchar(500),'
              'font_color INTEGER'
              ')');
        });
      }
    } catch (e) {
      String path = join(await getDatabasesPath(), 'q.db');
      _db = await openDatabase(path, version: 1,
          onCreate: (Database db, int v) async {
        await db.execute('CREATE TABLE q1 ('
            'id INTEGER PRIMARY KEY,'
            'title varchar(100),'
            'type varchar(100),'
            'data varchar(100) ,'
            'saved INTEGER ,'
            'description varchar(500),'
            'color INTEGER,'
            'image varchar(500),'
            'font_color INTEGER'
            ')');
      });
    }

    return _db;
  }

  addItem(ProductItem productItem) async {
    Database? db = await _createDatabase();
    notifyListeners();
    return db!.insert('q1', productItem.toMaps());
  }

  allDateItem() async {
    Database? db = await _createDatabase();
    db!.query('q1');
    notifyListeners();

    return db.query('q1');
  }

  countItem() async {
    Database? db = await _createDatabase();
    db!.query('q1').then((value) {
      notifyListeners();
      return value.length;
    });
  }

  deleteDateItem(id) async {
    Database db = await _createDatabase();
    db.delete('q1', where: 'id = ?', whereArgs: [id]).then((value) {
      notifyListeners();

      return value;
    });
  }

}
