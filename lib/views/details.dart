import 'package:chennai_task_2/views/home.dart';
import 'package:flutter/material.dart';
import 'package:chennai_task_2/constants/app_constants.dart';
import 'package:chennai_task_2/models/repo_model.dart';

class RepoDetailsPage extends StatefulWidget {
  final RepoModel repo;

  const RepoDetailsPage({Key? key, required this.repo}) : super(key: key);

  @override
  _RepoDetailsPageState createState() => _RepoDetailsPageState();
}

class _RepoDetailsPageState extends State<RepoDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Details'),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 60.0,
                  backgroundImage: NetworkImage(widget.repo.avatar),
                ),
                kHeight,
                StarWidget(starCount: widget.repo.stars),
                kHeight,
                kHeight,
                Text(
                  'Name:',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  widget.repo.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Owner Name:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  widget.repo.ownerName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                kHeight,
                kHeight,
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  widget.repo.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                kHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
