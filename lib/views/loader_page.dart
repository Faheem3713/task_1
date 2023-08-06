import 'package:chennai_task_2/controllers/repo_provider.dart';
import 'package:chennai_task_2/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    checkData(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkData(BuildContext context) async {
    Provider.of<RepoController>(context, listen: false).getRepo(0).then(
        (value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => MyHomePage()))));
  }
}
