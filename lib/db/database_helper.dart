import 'dart:collection';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_story_app/ConstantDatas.dart';
import 'package:flutter_story_app/model/ModelMainCat.dart';
import 'package:flutter_story_app/model/ModelSubCategory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'story_db.db';
  static final _databaseVersion = 1;
  static final tableMainCat = 'tbl_story_main_cat';
  static final tableSubCat = 'tbl_story';
  static final categoriesTable = 'categories';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database!;
  }

  _initDatabase() async {
    var databasepath = await getDatabasesPath();
    String path = join(databasepath, _databaseName);

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }

      ByteData data = await rootBundle.load(join("assets", _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    return await openDatabase(path, version: _databaseVersion, readOnly: false);
  }

  Future<int> insert(ModelMainCat mainCat) async {
    // Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    print("insertdata==${mainCat.catImg}");
    var map = new HashMap<String, dynamic>();
    // map['id']=modelMainCat.id;
    map['cat_img'] = mainCat.catImg;
    map['cat_name'] = mainCat.catName;

    return await db.insert(tableMainCat, map, nullColumnHack: 'id');
    // return await db.insert(table_main_cat, mainCat.toMap(),nullColumnHack: 'id');
  }
  Future<int> updateStory(ModelSubCategory mainCat) async {
    // Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var map = new HashMap<String, dynamic>();
    print("imgsave==${mainCat.img}");
    map['img'] = mainCat.img;
    map['title'] = mainCat.title;
    map['story'] = mainCat.story;
    map['main_cat_id'] = mainCat.mainCatId;
    map['mark_read'] = mainCat.markRead;
    map['fav'] = mainCat.fav;


    return await db.update(tableSubCat, map, where:  'id = ?',whereArgs: [mainCat.id]);
    // return await db.insert(table_main_cat, mainCat.toMap(),nullColumnHack: 'id');
  }

  Future<int> insertSubCat(String title, String story, String img) async {
    // Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var map = new HashMap<String, dynamic>();
    map['img'] = img;
    map['title'] = title;
    map['story'] = story;
    map['main_cat_id'] = ConstantDatas.yourStoryId;
    map['mark_read'] = 0;
    map['fav'] = 0;

    return await db.insert(tableSubCat, map, nullColumnHack: '');

  }

  Future<List> getAllMainCatList() async {
    Database database = await instance.database;
    // var results = await database.rawQuery(
    //     'SELECT * FROM tbl_story_main_cat WHERE ref_id = ?',
    //     [refId]);
    var results = await database.query(tableMainCat);
    return results.toList();
  }

  Future<List> getAllCategories() async {
    Database database = await instance.database;
    var results = await database.rawQuery(
        'SELECT * FROM categories',
        );
    // print('cfmkvnmvdfk');
    // var results = await database.query(categoriesTable);
    print('Categorires List ---->${results}');
    return results.toList();
  }

  Future<List> getAllSubCatList() async {
    Database database = await instance.database;
    // var results = await database.query("SELECT * FROM $table_main_cat");
    var results = await database.query(tableSubCat);
    return results.toList();
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database database = await instance.database;
    int id = row['id'];
    return await database
        .update(tableMainCat, row, where:  'id = ?', whereArgs: [id]);
  }

  Future<int> updateSubCatFav(ModelSubCategory modelSub) async {
    // Future<int> updateSubCatFav(Map<String, dynamic> row) async {
    Database database = await instance.database;
    var row = new HashMap<String, dynamic>();
    // row['id']=modelSub.id;
    row['fav'] = modelSub.fav;
    row['story'] = modelSub.story;
    row['title'] = modelSub.title;
    row['img'] = modelSub.img;
    row['main_cat_id'] = modelSub.mainCatId;
    row['mark_read'] = modelSub.markRead;

    int? id = modelSub.id;
    return await database
        .update(tableSubCat, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<ModelMainCat?> getMainCatByid(int id) async {
    // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
    // final db = assetDB;
    Database database = await instance.database;

    var res = await database
        .query(tableMainCat, where: "id" + " = ?", whereArgs: [id]);
    ModelMainCat? product =
        res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
    return product;
  }

  Future<List> getAllSubCatByMainCat(int id) async {
    // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
    // final db = assetDB;
    Database database = await instance.database;

    var res = await database
        .query(tableSubCat, where: "main_cat_id" + " = ?", whereArgs: [id]);
        // .query(tableSubCat, where: "main_cat_id" + " = ?", whereArgs: [1]);

    // ModelMainCat product =
    //     res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
    return res.toList();
  }

  Future<List> getAllFavItem() async {
    // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
    // final db = assetDB;
    Database database = await instance.database;

    var res = await database
        .query(tableSubCat, where: "fav" + " = ?", whereArgs: [1]);
        // .query(tableSubCat, where: "fav" + " = ?", whereArgs: [0]);
    // ModelMainCat product =
    //     res.isNotEmpty ? ModelMainCat.fromMap(res.first) : null;
    return res.toList();
  }

  Future<ModelSubCategory?> getSubCatByid(int id) async {
    // Future<ModelMainCat> getMainCatByid(Database assetDB, int id) async {
    // final db = assetDB;
    Database database = await instance.database;
    var res = await database
        .query(tableSubCat, where: "id" + " = ?", whereArgs: [id]);
    ModelSubCategory? product =
        res.isNotEmpty ? ModelSubCategory.fromMap(res.first) : null;
    return product;
  }

  Future<int> delete(int ids) async {
    Database database = await instance.database;
    return await database.delete(tableMainCat, where: 'id', whereArgs: [ids]);
  }
}
