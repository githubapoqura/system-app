// import 'package:flutter/material.dart';
// import 'package:untitled4/ui/Screens/login/login.dart';
//
//
// class Secondintroduction extends StatelessWidget {
//   const Secondintroduction({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 400,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/secondIntroduction.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 100),
//               const Text("Welcome to fci",
//                 style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(height: 40),
//               const Text("111",
//                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
//               ),
//               const SizedBox(height: 120),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(icon:Image.asset('assets/icons/skip2.png'), onPressed: () {
//        Navigator.push(context,MaterialPageRoute(builder: (context)=> const Login()));
//                   },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           Positioned(
//             top: 15,
//             left: 12,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.08),
//                   shape: BoxShape.circle,
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child:   IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Image.asset(
//                     'assets/icons/back2.png',
//                     height: 40,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           Positioned(
//             top: 40,
//             right: 20,
//             child: GestureDetector(
//               onTap: () {
//
//               },
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
