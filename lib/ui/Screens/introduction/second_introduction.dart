import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/login/login.dart';

class SecondIntroduction extends StatelessWidget {
  static const String routeName = '/second_introduction';

  const SecondIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/secondIntroduction.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 60),  // تعديل المسافة من 100 إلى 60
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Your Favourite Place To Learn What You Need To Become A Software Engineer❤",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 120),  // تعديل المسافة من 160 إلى 120
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/skip2.png'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),  // مسافة إضافية أسفل الزر
              ],
            ),
          ),

          Positioned(
            top: 15,
            left: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/icons/back2.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
