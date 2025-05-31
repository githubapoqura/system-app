import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/project_Dm.dart';
import 'package:untitled4/provider/project_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  void _addProject() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _linkController.text.isNotEmpty) {
      ProjectModel project = ProjectModel(
        title: _titleController.text,
        describtion: _descriptionController.text,
        date: DateTime.now(),
        link: _linkController.text,
      );

      Provider.of<ProjectProvider>(context, listen: false).addProject(project);

      _titleController.clear();
      _descriptionController.clear();
      _linkController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Project Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Project Description'),
              ),
              TextField(
                controller: _linkController,
                decoration: const InputDecoration(labelText: 'Project Link'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addProject,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProjectProvider>(context, listen: false).fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.projects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: projects.isEmpty
                  ? const Center(
                      child: Text('No projects added yet.',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    )
                  : ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(project.title ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(project.describtion ?? ''),
                                GestureDetector(
                                  onTap: () async {
                                    String webUrl =
                                        project.link ?? 'https://flutter.dev';
                                    if (!webUrl.startsWith('http')) {
                                      webUrl = 'https://$webUrl';
                                    }

                                    if (await canLaunchUrlString(webUrl)) {
                                      await launchUrlString(webUrl,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Can't launch $webUrl")),
                                      );
                                    }
                                  },
                                  child: Text(
                                    project.link ?? '',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: _showAddProjectDialog,
              child: const Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }
}
