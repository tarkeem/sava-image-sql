import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

class sqlHelper {
  static Database? _db;

  get db async {
    if (_db == null) {
      _db = await initiateDb();
    }
    return _db;
  }

  initiateDb() async {
    String dataBasePath = await getDatabasesPath();
    //dont forget .db
    String path = join(dataBasePath, 'data.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _OnCreate,
      version: 1
    );
    return myDb;
  }

  //it will be executed just for one time
  _OnCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE mypic(
    pic TEXT NOT NULL
  )
''');
  }

  Future selectDb(String sql) async {
    Database? myDb =await db;
    var res = await myDb!.rawQuery(sql);
    return res;
  }

  Future<int> insertDb(String sql,String data) async {
    Database? myDb =await db;
    var res = await myDb!.rawInsert(sql,[data]);
    return res;
  }

  upDateDb(String sql) async {
    Database? myDb = db;
    var res = await myDb!.rawUpdate(sql);
    return res;
  }

  deleteDb(String sql) async {
    Database? myDb =await db;
    var res = await myDb!.rawDelete(sql);
    return res;
  }
}