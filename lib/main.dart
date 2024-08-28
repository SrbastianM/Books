import 'package:flutter/material.dart';
import 'package:web_flutter/src/data/dio_service.dart';
import 'package:web_flutter/src/presentation/blocs/blocs.dart';
import 'package:web_flutter/src/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => BookBloc(dioService: DioService())..add(FetchBooks())),
      ],
      child: const MyApp(),
    );
  }
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
