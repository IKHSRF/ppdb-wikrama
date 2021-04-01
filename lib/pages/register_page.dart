import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/services/firebase/firebase_auth_services.dart';
import 'package:ppdb_wikrama/services/firebase/user_validation.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  static const String id = '/register';
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register"),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            TextButton(
              onPressed: () async {
                var user = await AuthServices.signUpWithEmailandPassword(
                  _emailController.text,
                  _passwordController.text,
                  'user',
                );
                if (user != 'success') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(user)));
                } else {
                  Navigator.pushNamed(context, UserValidation.id);
                }
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
