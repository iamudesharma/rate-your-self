import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lordicon.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, bool isLoading, child) {
              if (isLoading) {
                return const LoadingPage();
              }
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        minWidth: 400,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text("Sign In",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     hintText: "Enter your name",
                            //     isDense: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            //   controller: _emailController,
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter your Password",
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FilledButton.icon(
                              icon: const Icon(Icons.save),
                              label: const Text('Submit'),
                              onPressed: () async {
                                _isLoading.value = true;
                                await Future.delayed(
                                    const Duration(seconds: 5));
                                _isLoading.value = false;
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.push("/sign-up");
                                      },
                                    text: " Sign Up",
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(LottieFiles.$81710_load_icon,
            height: 100,
            width: 100,
            animate: true,
            options: LottieOptions(enableMergePaths: true)),
      ),
    );
  }
}
