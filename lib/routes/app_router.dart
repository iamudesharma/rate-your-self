import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rate_your_self/auth/views/forgot_password_view.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/views/sign_in_view.dart';
import '../auth/views/sign_up_view.dart';
import '../home/home_view.dart';
import '../main.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return _appRoute(ref);
});

GoRouter _appRoute(Ref ref) {
  return GoRouter(initialLocation: "/", debugLogDiagnostics: true, routes: [
    GoRoute(
      path: '/sign-in',
      pageBuilder: (context, state) => CupertinoPage(child: const SignInView()),
    ),
    GoRoute(
      path: '/sign-up',
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpView(),
      ),

      // builder: (context, state) =>
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => CupertinoPage(
        child: ForgotPasswordView(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const CupertinoPage(child: HomeView()),
      redirect: (context, state) {
        return ref.read(supabaseProvider).auth.currentUser != null
            ? null
            : '/sign-in';
      },
    ),
  ]);
}
