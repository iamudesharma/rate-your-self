import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rate_your_self/auth/repo/auth_repo.dart';
import 'package:rate_your_self/auth/views/sign_in_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Sign Up",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your name",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: _usernameController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your Password",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: _passwordController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FilledButton.icon(
                                icon: const Icon(Icons.save),
                                label: const Text('Submit'),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _isLoading.value = true;
                                    final _route = GoRouter.of(context);

                                    await ref.read(authRepoProvider).signUp(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                        username: _usernameController.text);

                                    _isLoading.value = false;

                                    _route.replace("/sign-in");
                                  }
                                  // _isLoading.value = true;
                                  // await Future.delayed(
                                  //     const Duration(seconds: 5));
                                  // _isLoading.value = false;
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Already an account?",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.push("/sign-in");
                                        },
                                      text: " Sign In",
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
                ),
              );
            }),
      ),
    );
  }
}
