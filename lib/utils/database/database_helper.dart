import 'dart:io';
import 'package:gemini/screen/history/model/history_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper helper = DbHelper._();

  DbHelper._();

  Database? database;
  final String DB_NAME = "data.db";

  Future<Database> checkDb() async {
    if (database != null) {
      return database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    checkDb();
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        String queryAiTable =
            "CREATE TABLE gemini(id INTEGER PRIMARY KEY AUTOINCREMENT,answer TEXT)";
        db.execute(queryAiTable);
      },
    );
  }

  Future<void> insertData(HistoryModel historyModel) async {
    database = await checkDb();
    database!.insert("gemini", {
      "answer":historyModel.answer,
    });
  }

  Future<List<HistoryModel>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM gemini";
    List<Map> data = await database!.rawQuery(query, null);
    List<HistoryModel> modelList =
    data.map((e) => HistoryModel.mapToModel(e)).toList();
    return modelList;
  }

  Future<void> deleteData({required String id}) async {
    database = await checkDb();
    database!.delete("gemini", where: "id=?", whereArgs: [id]);
  }
}