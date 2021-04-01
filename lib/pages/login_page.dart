import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/pages/register_page.dart';
import 'package:ppdb_wikrama/services/firebase/firebase_auth_services.dart';
import 'package:ppdb_wikrama/services/firebase/user_validation.dart';

class LoginPage extends StatelessWidget {
  static const String id = '/';
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
            Text("Login"),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            TextButton(
              onPressed: () async {
                var user = await AuthServices.loginWithEmailandPassword(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user != 'success') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(user)));
                } else {
                  Navigator.pushNamed(context, UserValidation.id);
                }
              },
              child: Text(
                "login",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: Text(
                    "Register",
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
