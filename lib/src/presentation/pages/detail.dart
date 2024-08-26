import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_flutter/src/presentation/blocs/blocs.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    // instance of the class
    final detailCubit = context.watch<DetailCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Center(
        child: Text(detailCubit.state),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detailCubit.setUsername("Sebastian");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
