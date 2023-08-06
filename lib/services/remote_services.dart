import 'dart:convert';
import 'package:chennai_task_2/services/local_services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../models/repo_model.dart';

class RemoteSservices {
  RemoteSservices._();

  static final instance = RemoteSservices._();
  Future<void> getDataFromRemote(Database db, int limit) async {
    final formatedDate = DateFormat('y-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 30)));
    String url =
        'https://api.github.com/search/repositories?q=created:>$formatedDate&sort=stars&order=desc';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      limit == 0 ? db.delete('RepoDatas') : ();
      for (var e in (json.decode(response.body)['items'] as List)
          .sublist(limit, limit + 9)) {
        RepoServices.instance.insert(RepoModel.fromJson(e, false).toJson());
      }
    }
  }
}
