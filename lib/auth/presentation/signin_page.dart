// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketnotes/auth/presentation/signup_page.dart';
import 'package:pocketnotes/auth/services/auth_services.dart';
import 'package:pocketnotes/home/presentation/home_page.dart';
import 'package:pocketnotes/shared/presentation/widgets/loader_dialog.dart';
import 'package:validators/validators.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Container(
            height: 225,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.onBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pocket Notes",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!isEmail(value)) {
                        return 'Please enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'Minimum 6 characters';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.onBackground,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background,
                        ),
                        elevation: MaterialStateProperty.all(
                          0,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showLoaderDialog(context);
                          String login = await ref.watch(
                            loginWithEmailProvider(
                              [
                                _emailController.text,
                                _passwordController.text,
                              ],
                            ),
                          );
                          Navigator.pop(context);
                          if (login == "Success") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const HomePage()),
                              ),
                              (route) => false,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text(
                                    "Error! Try signing up, or enter proper credentials.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Sign In",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                              (route) => false);
                        },
                        child: const Text(
                          "Sign In",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
