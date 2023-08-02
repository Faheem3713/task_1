import 'dart:developer';

import 'package:chennai_task_2/models/repo_model.dart';
import 'package:chennai_task_2/services/get_repo_data.dart';
import 'package:flutter/material.dart';

class RepoController extends ChangeNotifier {
  List<RepoModel> _repo = [];
  List<RepoModel> get repo => _repo;
  final _repoServices = RepoServices.instance;
  bool isLoading = true;
  bool isError = false;

  //get loaded data to controller
  void getRepo() async {
    try {
      _repo = await _repoServices.getData();
    } catch (e) {
      log(e.toString());
      isError = true;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
