// ignore_for_file: control_flow_in_finally

import 'dart:developer';
import 'package:chennai_task_2/models/repo_model.dart';
import 'package:chennai_task_2/services/remote_services.dart';
import 'package:sqflite/sqflite.dart';

class RepoServices {
  RepoServices._();
  static final instance = RepoServices._();

  Database? database;
  static const String dbName = 'repo.db';
  static const String tableName = 'RepoDatas';

  Future<void> initDb() async {
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
  }

  //get Data from api
  Future<void> addData(int limit) async {
    try {
      await RemoteSservices.instance.getDataFromRemote(database!, limit);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> insert(Map<String, dynamic> data) async {
    await database!.insert(tableName, data).then((value) => log('inserted'));
  }

  Future<List<RepoModel>> getData(int limit) async {
    try {
      await addData(limit);
    } catch (_) {
    } finally {
      final result = await database!
          .rawQuery('SELECT * FROM $tableName LIMIT 10 OFFSET ${limit * 10}');

      return result.map((e) => RepoModel.fromJson(e, true)).toList();
    }
  }
}

enum Status { success, error }
