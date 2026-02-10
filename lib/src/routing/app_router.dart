import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/home/presentation/home_screen.dart';
import 'package:linguabridge/src/features/image_capture/presentation/image_capture_page.dart';
import 'package:linguabridge/src/features/translation/presentation/translation_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'translation',
            builder: (context, state) => const TranslationPage(),
          ),
          GoRoute(
            path: 'image_capture',
            builder: (context, state) => const ImageCapturePage(),
          ),
        ],
      ),
    ],
  );
}
