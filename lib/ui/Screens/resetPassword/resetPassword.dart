import 'package:flutter/material.dart';

import '../Verify/verify.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'assets/images/Reset password.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // العنوان
            const Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // الحقول النصية
            const Text(
              'New Password',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            _buildPasswordField(),
            const SizedBox(height: 15),
            const Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            _buildPasswordField(),
            const SizedBox(height: 30),
            // زر Reset Password
            ElevatedButton(
              onPressed: () {
                // أكشن زر Reset Password
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
                  'Reset password',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // زر Cancel
            OutlinedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const Verify()));
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
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء حقل إدخال كلمة المرور
  Widget _buildPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'enter your password',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
      ),
    );
  }
}
