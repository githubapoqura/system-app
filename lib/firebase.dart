import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled4/project_Dm.dart';
import 'package:untitled4/userDm.dart';

class Services {
  static CollectionReference<ProjectModel> getProjectCollection() =>
      getUserCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('projects')
          .withConverter<ProjectModel>(
            fromFirestore: (snapshot, _) => ProjectModel.fromJson(
                snapshot.data() ?? {}, snapshot.id), // ✅ تعديل هنا
            toFirestore: (value, _) => value.toJson(),
          );

  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );

  static Future<UserModel> signup(UserModel userModel, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email.trim(), password: password);
      userModel.id = credential.user?.uid;
      await createUser(userModel);
      return userModel;
    } catch (e) {
      print("Firebase signup error: $e");
      rethrow;
    }
  }

  static Future<void> createUser(UserModel userModel) async {
    return await getUserCollection().doc(userModel.id).set(userModel);
  }

  static Future<UserModel?> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return getUser();
  }

  static Future<UserModel?> getUser() async {
    DocumentSnapshot<UserModel> documentSnapshot = await getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return documentSnapshot.data();
  }

  static Future<void> addProject(ProjectModel project) {
    CollectionReference<ProjectModel> tasksCollection = getProjectCollection();
    DocumentReference<ProjectModel> documentReference = tasksCollection.doc();
    project.id = documentReference.id;
    return documentReference.set(project);
  }

  static Future<List<ProjectModel>> getProjects() async {
    CollectionReference<ProjectModel> projectsCollection =
        getProjectCollection();
    QuerySnapshot<ProjectModel> snapshot = await projectsCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
