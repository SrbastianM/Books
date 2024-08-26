import 'package:go_router/go_router.dart';
import 'package:web_flutter/src/presentation/pages/detail.dart';
import 'package:web_flutter/src/presentation/pages/home.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
    GoRoute(path: '/detail', builder: (context, state) => const Detail()),
  ],
);
