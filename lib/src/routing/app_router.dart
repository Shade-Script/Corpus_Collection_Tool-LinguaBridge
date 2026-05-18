import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/home/presentation/home_screen.dart';
import 'package:linguabridge/src/features/home/presentation/leaderboard_screen.dart';
import 'package:linguabridge/src/features/main/presentation/main_navigation_screen.dart';
import 'package:linguabridge/src/features/translation/presentation/translation_page.dart';
import 'package:linguabridge/src/features/language/presentation/register_language_page.dart';
import 'package:linguabridge/src/features/dictionary/presentation/language_detail_page.dart';
import 'package:linguabridge/src/features/dictionary/presentation/dictionary_page.dart';
import 'package:linguabridge/src/features/auth/presentation/sign_in_screen.dart';
import 'package:linguabridge/src/features/auth/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authState = ref.watch(authStateChangesProvider);
  
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth = authState.valueOrNull != null;
      final isGoingToSignIn = state.matchedLocation == '/signin';

      // If user is not authenticated and is not currently going to sign in, force them there.
      if (!isAuth && !isGoingToSignIn) {
        return '/signin';
      }
      
      // If user IS authenticated but is trying to access sign in screen, bump them to home.
      if (isAuth && isGoingToSignIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'leaderboard',
                    builder: (context, state) => const LeaderboardScreen(),
                  ),
                ],
              ),
            ],
          ),
          
          // Branch 2: Contribute (Word + Register Language)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/contribute',
                builder: (context, state) => const TranslationPage(),
                routes: [
                  GoRoute(
                    path: 'register',
                    builder: (context, state) => const RegisterLanguagePage(),
                  )
                ]
              ),
            ],
          ),

          // Branch 3: Dictionary
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dictionary',
                builder: (context, state) => const DictionaryPage(),
                routes: [
                  GoRoute(
                    path: ':languageName',
                    builder: (context, state) => LanguageDetailPage(
                      languageName: state.pathParameters['languageName']!,
                    ),
                  )
                ]
              ),
            ],
          ),
        ],
      )
    ],
  );
}
