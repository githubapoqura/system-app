// import 'package:flutter/material.dart';
// import 'package:untitled4/ui/Screens/schedule/schedule_page.dart';
// import 'package:untitled4/ui/summary/summary_page.dart';
//
// class ChooseScheduleSemester extends StatelessWidget {
//   final String yearId;
//
//   const ChooseScheduleSemester({super.key, required this.yearId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('choose-semester')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Card(
//             child: ListTile(
//               title: const Text('semester-one'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => TablePage(yearId: yearId, semester: 1),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Card(
//             child: ListTile(
//               title: const Text('semester-two'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => TablePage(yearId: yearId, semester: 2),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
