import 'dart:developer';

import 'package:chennai_task_2/models/repo_model.dart';
import 'package:chennai_task_2/services/local_services.dart';
import 'package:flutter/material.dart';

class RepoController extends ChangeNotifier {
  final List<RepoModel> _repo = [];
  List<RepoModel> get repo => _repo;
  final _repoServices = RepoServices.instance;
  bool isLoading = true;
  bool isError = false;

  //get loaded data to controller
  Future<void> getRepo(int limit) async {
    try {
      if (limit <= 3) {
        print(limit);
        final result = await _repoServices.getData(limit);

        _repo.addAll(result);
        isError = false;
      }
    } catch (e) {
      log(e.toString());
      isError = true;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
