import 'dart:convert';
import 'dart:developer';

import 'package:chennai_task_2/models/repo_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../constants/app_constants.dart';

class RepoServices {
  RepoServices._();
  static final instance = RepoServices._();

  Database? database;
  static const String dbName = 'repo.db';
  static const String tableName = 'RepoDatas';

  Future<void> initDb() async {
    await deleteDatabase(dbName);
    database = await openDatabase(
      dbName,
      version: 1,
      onCreate: (db, version) async {
        return db
            .execute(
                'CREATE TABLE $tableName(name TEXT,description TEXT,login TEXT,avatar_url TEXT,stargazers_count INTEGER)')
            .then((value) => log('cre'));
      },
    );
    await addData();
  }

  //get Data from api
  Future<void> addData() async {
    final response = await http.get(Uri.parse(baseUrl));
    for (var e in (json.decode(response.body)['items'] as List)) {
      insert(RepoModel.fromJson(e, false).toJson());
    }
  }

  Future<void> insert(Map<String, dynamic> data) async {
    await database!.insert(tableName, data).then((value) => log('inserted'));
  }

  Future<List<RepoModel>> getData() async {
    final result = await database!.rawQuery('SELECT * FROM $tableName');

    return result.map((e) => RepoModel.fromJson(e, true)).toList();
  }
}
