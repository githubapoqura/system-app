import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/provider/books_provider.dart';
import 'package:untitled4/provider/project_provider.dart';
import 'package:untitled4/provider/summary_provider.dart';
import 'package:untitled4/provider/user_provider.dart';
import 'package:untitled4/ui/Screens/introduction/introduction.dart';
import 'package:untitled4/ui/Screens/introduction/second_introduction.dart';
import 'package:untitled4/ui/Screens/login/login.dart';
import 'package:untitled4/ui/Screens/signUp/signUp.dart';
import 'package:untitled4/ui/Screens/splash/splash.dart';
import 'package:untitled4/ui/Screens/schedule/schedule_page.dart';
import 'package:untitled4/ui/Screens/icon_page/summer_course_page.dart';
import 'package:untitled4/ui/summary/summary_page.dart';
import 'package:untitled4/ui/Screens/icon_page/registration_page.dart';
import 'package:untitled4/ui/Screens/icon_page/projects_page.dart';
import 'package:untitled4/ui/Screens/icon_page/payment_page.dart';
import 'package:untitled4/ui/Screens/gpa/gpa_page.dart';
import 'package:untitled4/ui/Screens/student/student.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(
        create: (_) => ProjectProvider()
          ..fetchProjects()
          ..loadNews()),
    ChangeNotifierProvider(create: (_) => BooksProvider()),
    ChangeNotifierProvider(create: (_) => SummaryProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Splash.routeName,
      routes: {
        '/student': (_) => const Student(),
        Splash.routeName: (_) => const Splash(),
        '/login': (_) => const Login(),
        '/signUp': (_) => const Signup(),
        Introduction.routeName: (_) => const Introduction(),
        SecondIntroduction.routeName: (_) => const SecondIntroduction(),
        //'/table': (_) => const TablePage(),
        '/summer_course': (_) => const SummerCoursePage(),
        //'/summary': (_) => const SummaryPage(),
        '/registration': (_) => const RegistrationPage(),
        '/projects': (_) => const ProjectsPage(),
        '/payment': (_) => const PaymentPage(),
        '/gpa': (_) => const GpaPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
