import 'package:chennai_task_2/controllers/repo_provider.dart';
import 'package:chennai_task_2/views/loader_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/local_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RepoServices.instance.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RepoController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoaderPage(),
      ),
    );
  }
}
