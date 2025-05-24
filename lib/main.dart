import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/introduction/introduction.dart';
import 'package:untitled4/ui/Screens/splash/splash.dart';
import 'package:untitled4/ui/Screens/icon_page/table_page.dart';
import 'package:untitled4/ui/Screens/icon_page/summer_course_page.dart';
import 'package:untitled4/ui/Screens/icon_page/summary_page.dart';
import 'package:untitled4/ui/Screens/icon_page/registration_page.dart';
import 'package:untitled4/ui/Screens/icon_page/projects_page.dart';
import 'package:untitled4/ui/Screens/icon_page/payment_page.dart';
import 'package:untitled4/ui/Screens/icon_page/gpa_page.dart';
import 'package:untitled4/ui/Screens/student/student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Splash.routeName,

      routes: {
        '/': (_) => const Student(),
        Splash.routeName: (_) => const Splash(),
        Introduction.routeName: (_) => const Introduction(),
        '/table': (_) => const TablePage(),
        '/summer_course': (_) => const SummerCoursePage(),
        '/summary': (_) => const SummaryPage(),
        '/registration': (_) => const RegistrationPage(),
        '/projects': (_) => const ProjectsPage(),
        '/payment': (_) => const PaymentPage(),
        '/gpa': (_) => const GpaPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
