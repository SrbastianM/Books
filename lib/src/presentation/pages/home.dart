import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_flutter/src/presentation/widgets/header.dart';
import 'package:web_flutter/src/presentation/widgets/list_character.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Header(),
          const ListCharacter(),
          const Text("Home"),
          ElevatedButton(
            onPressed: () {
              context.go("/detail");
            },
            child: const Text("Detail"),
          ),
        ],
      ),
    );
  }
}
