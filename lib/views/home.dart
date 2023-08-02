import 'package:chennai_task_2/services/get_repo_data.dart';
import 'package:chennai_task_2/views/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/repo_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    RepoServices.instance.getData();
    Provider.of<RepoController>(context, listen: false).getRepo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository List'),
      ),
      body: Consumer<RepoController>(builder: (context, repoData, _) {
        return
            //handle loading state
            repoData.isLoading
                ? const Center(child: CircularProgressIndicator())
                :
                //handle error state
                repoData.isError
                    ? const Center(child: Text('Something went wrong'))
                    :
                    //handle success state
                    ListView.builder(
                        itemCount: repoData.repo.length,
                        itemBuilder: (context, index) {
                          final data = repoData.repo[index];
                          return Card(
                            child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RepoDetailsPage(repo: data),
                                    )),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data.avatar),
                                ),
                                title: Text(data.name),
                                subtitle: Text(data.ownerName),
                                trailing: StarWidget(starCount: data.stars)),
                          );
                        },
                      );
      }),
    );
  }
}

class StarWidget extends StatelessWidget {
  const StarWidget({super.key, required this.starCount});
  final int starCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 30,
      color: Colors.yellow,
      child: Text(
        '$starCount★',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
