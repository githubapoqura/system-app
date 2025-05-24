import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/resetPassword/resetPassword.dart';

import '../forgetPassword/forgetPassword.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  'assets/icons/back.png',
                  height: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Image.asset(
              'assets/images/Verified.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            const Text(
              'Verify your email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'please enter the 4 digit code sent to\nyouremail@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPinBox(),
                _buildPinBox(),
                _buildPinBox(),
                _buildPinBox(),
              ],
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> const ResetPassword()) );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> const ForgetPassword()) );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // زر إعادة الإرسال
            GestureDetector(
              onTap: () {
                // أكشن إعادة إرسال الكود
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // عنصر مخصص لحقل إدخال الرمز
  Widget _buildPinBox() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
