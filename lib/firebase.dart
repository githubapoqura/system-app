import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled4/news_model.dart';
import 'package:untitled4/project_Dm.dart';
import 'package:untitled4/subject_DM.dart';
import 'package:untitled4/ui/Screens/book_Dm.dart';
import 'package:untitled4/ui/Screens/schedule/schedule_dm.dart';
import 'package:untitled4/ui/summary/summary_dm.dart';
import 'package:untitled4/userDm.dart';

class Services {
  static CollectionReference<ProjectModel> getProjectCollection() =>
      getUserCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('projects')
          .withConverter<ProjectModel>(
            fromFirestore: (snapshot, _) =>
                ProjectModel.fromJson(snapshot.data() ?? {}, snapshot.id),
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

  CollectionReference<SubjectModel> getSubjectCollection() =>
      getUserCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('registered_subjects')
          .withConverter<SubjectModel>(
            fromFirestore: (snapshot, _) =>
                SubjectModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );

  Future<void> registerCourses(List<SubjectModel> courses) async {
    final subjectCollection = getSubjectCollection();
    for (final course in courses) {
      final docRef = subjectCollection.doc();
      await docRef.set(course);
    }
  }

  Future<List<SubjectModel>> fetchRegisteredSubjects() async {
    final subjectCollection = getSubjectCollection();
    final snapshot = await subjectCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> clearCourses() async {
    final subjectCollection = getSubjectCollection();
    final snapshot = await subjectCollection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  CollectionReference<SubjectModel> getSummerSubjectCollection() =>
      getUserCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('registered_summer_subjects')
          .withConverter<SubjectModel>(
            fromFirestore: (snapshot, _) =>
                SubjectModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );

  Future<void> registerSummerCourses(List<SubjectModel> summerCourses) async {
    final summerCollection = getSummerSubjectCollection();
    for (final course in summerCourses) {
      final docRef = summerCollection.doc();
      await docRef.set(course);
    }
  }

  Future<List<SubjectModel>> fetchRegisteredSummerSubjects() async {
    final summerCollection = getSummerSubjectCollection();
    final snapshot = await summerCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> clearSummerCourses() async {
    final summerCollection = getSummerSubjectCollection();
    final snapshot = await summerCollection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<NewsModel>> fetchNewsFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('news')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return NewsModel.fromJson(doc.data(), doc.id);
    }).toList();
  }






  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BookModel>> getBooksForSemester({
    required String yearId,
    required String semesterId,
  }) async {
    final querySnapshot = await _firestore
        .collection('books_sections')
        .doc(yearId)
        .collection('semesters')
        .doc(semesterId)
        .collection('books')
        .get();

    return querySnapshot.docs.map((doc) {
      return BookModel.fromMap(doc.data());
    }).toList();
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<List<SummaryModel>> getSummeryForSemester({
    required String yearId,
    required String semesterId,
  }) async {
    final querySnapshot = await fireStore
        .collection('summary_sections')
        .doc(yearId)
        .collection('semesters')
        .doc(semesterId)
        .collection('books')
        .get();

    return querySnapshot.docs.map((doc) {
      return SummaryModel.fromMap(doc.data());
    }).toList();
  }





  Future<List<ScheduleDm>> getSchedule({
    required String yearId,
    String? departmentId,
  }) async {
    final fireStoreQuery = FirebaseFirestore.instance;

    if (departmentId != null) {
      final collectionRef = fireStoreQuery
          .collection('schedule_sections')
          .doc(yearId)
          .collection('departments')
          .doc(departmentId)
          .collection('schedule');

      final querySnap = await collectionRef.get();

      return querySnap.docs.map((doc) => ScheduleDm.fromMap(doc.data())).toList();
    } else {
      final departmentsSnapshot = await fireStoreQuery
          .collection('schedule_sections')
          .doc(yearId)
          .collection('departments')
          .get();

      if (departmentsSnapshot.docs.isNotEmpty) {
        List<ScheduleDm> allSchedules = [];

        for (var deptDoc in departmentsSnapshot.docs) {
          final scheduleSnapshot = await deptDoc.reference.collection('schedule').get();

          final schedules = scheduleSnapshot.docs.map((doc) {
            return ScheduleDm.fromMap(doc.data());
          }).toList();

          allSchedules.addAll(schedules);
        }

        return allSchedules;
      } else {
        final generalScheduleRef = fireStoreQuery
            .collection('schedule_sections')
            .doc(yearId)
            .collection('schedule');

        final generalSnap = await generalScheduleRef.get();

        return generalSnap.docs.map((doc) => ScheduleDm.fromMap(doc.data())).toList();
      }
    }
  }

}
