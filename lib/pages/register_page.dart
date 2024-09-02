import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //form key
  final formekey = GlobalKey<FormState>();

  //text controllers
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // create user

  void createUserWithEmailAndPassword() async {
    //loading aniimation
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
      if (userPasswordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: userPasswordController.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // print(e);
    }
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
                child: Column(children: [
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
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z 0-9]+$')
                                      .hasMatch(value)) {
                                return 'Enter coorect password';
                              }
                            },
                          ),

                          //confirm password
                          const SizedBox(height: 25.00),

                          TextFormField(
                              controller: confirmPasswordController,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password'),
                              obscureText: true,
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-z A-Z 0-9]+$')
                                        .hasMatch(value)) {
                                  return 'Enter coorect password';
                                }
                              }),
                        ],
                      )),
                ]),
              ),

              const SizedBox(height: 150.00),

              //submit button
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () {
                  if (formekey.currentState!.validate()) {
                    createUserWithEmailAndPassword();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Logged in')));
                  }
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 25.00),

              //toggle to login pagee
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a member? '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login now',
                      style: TextStyle(color: Colors.purple[600]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25.00,
              )
            ],
          ),
        ));
  }
}
