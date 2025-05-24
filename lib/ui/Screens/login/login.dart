import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/forgetPassword/forgetPassword.dart';
import 'package:untitled4/ui/Screens/home/home.dart';
import 'package:untitled4/ui/Screens/signUp/signUp.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/icons/back.png',
                    height: 40,
                  ),
                ),
                const SizedBox(width: 110,),
                const Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Text("Email",style: TextStyle(fontSize: 18,
              fontWeight:FontWeight.w400,
              color: Colors.black,
            ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter your email",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Password",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter your password",
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Text("Remember me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> const ForgetPassword()) );
                  },
                  child: const Text(
                    "forget password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 70),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const Home()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 20, color: Colors.white ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Center(
              child: Text(
                "or continue with",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                onPressed: () {// Function for Google sign-in
                },
                icon: Image.asset(
                  'assets/icons/google.png',
                  height: 40,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Continue as a guest",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Didn't have an account? ",
                  style: const TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "sign up",
                      style: const TextStyle(fontSize: 16, color: Colors.blue),

                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const Signup()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
