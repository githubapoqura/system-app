import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/provider/user_provider.dart';
import 'package:untitled4/ui/Screens/forgetPassword/forgetPassword.dart';
import 'package:untitled4/ui/Screens/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text("Email", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter your email",
                ),
              ),
              const SizedBox(height: 20),
              const Text("Password", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                      );
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
                  onPressed: provider.loading
                      ? null
                      : () async {
                          final success = await provider.login(
                            context,
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(170, 50),
                    backgroundColor: Colors.blue,
                  ),
                  child: provider.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Log in",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("or continue with", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Center(
                child: IconButton(
                  onPressed: () {
                    // TODO: Google sign-in
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't have an account? ",
                        style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUp');
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
