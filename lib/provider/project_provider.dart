import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/project_Dm.dart';

class ProjectProvider extends ChangeNotifier {
  ProjectModel? projectModel;
  bool loading = false;
  List<ProjectModel> projects = [];
  Future<void> addProject(ProjectModel project) async {
    loading = true;
    notifyListeners();
    await Services.addProject(project);
    projects.add(project);
    loading = false;
    notifyListeners();
  }

  Future<void> fetchProjects() async {
    loading = true;
    notifyListeners();
    projects = await Services.getProjects();
    loading = false;
    notifyListeners();
  }
}
