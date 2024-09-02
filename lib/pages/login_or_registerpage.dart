import 'package:flutter/material.dart';
import 'package:form/pages/loggin_page.dart';
import 'package:form/pages/register_page.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool showLogingpage = true;

  void togglePages() {
    setState(() {
      showLogingpage = !showLogingpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogingpage) {
      return LoggingPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
