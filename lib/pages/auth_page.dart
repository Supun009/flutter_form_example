import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/home_page.dart';
import 'package:form/pages/login_or_registerpage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //if user logged in
          return HomePage();
        } else {
          //if use not logged in
          return const LoginRegisterPage();
        }
      },
    ));
  }
}
