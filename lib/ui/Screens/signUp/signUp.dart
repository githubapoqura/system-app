import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/home/home.dart';
import 'package:untitled4/ui/Screens/login/login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Row(
                children: [

                  SizedBox(width: 140,),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
              const Text("Phone number",style: TextStyle(fontSize: 18,
                fontWeight:FontWeight.w400,
                color: Colors.black,
              ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  hintText: 'Phone number',
                  border: const OutlineInputBorder(),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/icons/flag.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '+20',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20,),

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
              const SizedBox(height: 20),
              const Text("Confirm Password",
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
              const SizedBox(height: 40),
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
                    "Sign Up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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


              const SizedBox(height: 70),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Log in ",
                        style: const TextStyle(fontSize: 16, color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const Login()));
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
