import 'package:flutter/material.dart';
import 'package:web_flutter/src/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "One Piece ",
      routerConfig: appRouter,
    );
  }
}
