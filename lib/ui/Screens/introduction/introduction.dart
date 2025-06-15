import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/introduction/second_introduction.dart';

class Introduction extends StatelessWidget {
  static const String routeName = "introduction";
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/introduction.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 100),
          const Text(" WELCOME TO FCI ❤ ",

            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700
                ,fontStyle: FontStyle.italic),

          ),
          const SizedBox(height: 140),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Image.asset('assets/icons/skip.png'), onPressed: () {
                Navigator.pushNamed(context, SecondIntroduction.routeName);
              },
              ),
            ],
          )
        ],
      ),
    );
  }
}
