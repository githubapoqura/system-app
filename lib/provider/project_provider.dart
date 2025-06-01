import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/news_model.dart';
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

  final Services _newsService = Services();
  List<NewsModel> _newsItems = [];

  List<NewsModel> get newsItems => _newsItems;

  Future<void> loadNews() async {
    _newsItems = await _newsService.fetchNewsFromFirebase();
    notifyListeners();
  }
}
