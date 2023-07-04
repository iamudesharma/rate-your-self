import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rate_your_self/auth/views/forgot_password_view.dart';
import 'package:rate_your_self/home/profile_view.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/views/sign_in_view.dart';
import '../auth/views/sign_up_view.dart';
import '../home/home_view.dart';
import '../main.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return _appRoute(ref);
});

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

GoRouter _appRoute(Ref ref) {
  return GoRouter(initialLocation: "/", debugLogDiagnostics: true, routes: [
    GoRoute(
      path: '/sign-in',
      pageBuilder: (context, state) => const CupertinoPage(child: SignInView()),
    ),
    GoRoute(
      path: '/sign-up',
      pageBuilder: (context, state) => const CupertinoPage(
        child: SignUpView(),
      ),

      // builder: (context, state) =>
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => const CupertinoPage(
        child: ForgotPasswordView(),
      ),
    ),
    // GoRoute(
    //   path: '/',
    //   pageBuilder: (context, state) => const CupertinoPage(child: HomeView()),

    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // first branch (A)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              redirect: (context, state) {
                return ref.read(supabaseProvider).auth.currentUser != null
                    ? null
                    : '/sign-in';
              },
              path: '/',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeView()),
            ),
          ],
        ),
        // second branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileView()),
            ),
          ],
        ),
      ],
    ),
  ]);
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          // CircularProgressIndicator.adaptive
          NavigationDestination(label: 'Home', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Profile', icon: Icon(Icons.person_2)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
