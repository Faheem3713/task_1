import 'package:chennai_task_2/views/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/repo_provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  int count = 0;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Repository List'),
      ),
      body: Consumer<RepoController>(builder: (context, repoData, _) {
        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            Future.delayed(
                const Duration(seconds: 3), () => repoData.getRepo(++count));
          }
        });
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
                        controller: scrollController,
                        itemCount: repoData.repo.length + 1,
                        itemBuilder: (context, index) {
                          if (index == repoData.repo.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
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
                          }
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
