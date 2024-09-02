import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggingPage extends StatefulWidget {
  final Function()? onTap;

  const LoggingPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();

  final formekey = GlobalKey<FormState>();

  void signInWithEmailAndPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final email = userNameController.text.trim();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: userPasswordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage(e.message);
      } else if (e.code == 'wrong-password') {
        showErrorMessage(e.message);
      } else if (e.code == 'invalid-email') {
        showErrorMessage(e.message);
      } else {
        // For other errors
        showErrorMessage(e.message);
      }
    }
  }

  void showErrorMessage(String? message) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[200],
            title: Text(message.toString()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formekey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.00,
                  ),
                  const Text(
                    'Welcome again',
                    style: TextStyle(fontSize: 40, color: Colors.blue),
                  ),

                  const SizedBox(height: 25.00),

                  //formfeald
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: userNameController,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          obscureText: false,
                          // ignore: body_might_complete_normally_nullable
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter correct name';
                            }
                          },
                        ),
                        const SizedBox(height: 25.00),
                        TextFormField(
                          controller: userPasswordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          // ignore: body_might_complete_normally_nullable
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                              return 'Enter coorect password';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 250.00),

            //submit button
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                if (formekey.currentState!.validate()) {
                  signInWithEmailAndPassword();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Logged in')));
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20.00),

            //register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a member? '),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(color: Colors.purple[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25.00,
            )
          ],
        ),
      ),
    );
  }
}
