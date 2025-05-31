import 'package:flutter/material.dart';
import '../firebase.dart';
import '../userDm.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  bool loading = false;

  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      loading = true;
      notifyListeners();

      userModel = await Services.login(email, password);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );

      return false;
    }
  }

  Future<bool> signUp(
      BuildContext context, UserModel user, String password) async {
    try {
      loading = true;
      notifyListeners();

      userModel = await Services.signup(user, password);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();

      print("SIGN UP ERROR: $e"); // اطبع الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Create account failed: $e"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );

      return false;
    }
  }
}
