import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'product_item.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  late Database _db;
  _createDatabase() async {
    if (_db != null) return _db;

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
    return _db;
  }

  addItem(ProductItem productItem) async {
    Database db = await _createDatabase();
    return db.insert('q1', productItem.toMaps());
  }

  allDateItem() async {
    Database db = await _createDatabase();
    db.query('q1');
    return db.query('q1');
  }

  countItem() async {
    Database db = await _createDatabase();
    db.query('q1').then((value) {
      print(value.length);
      return value.length;
    });
  }

  deleteDateItem(id) async {
    Database db = await _createDatabase();
    db.delete('q1', where: 'id = ?', whereArgs: [id]).then((value) {
      print('delate');
      print(value);
      return value;
    });
  }
}
