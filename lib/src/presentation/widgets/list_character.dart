import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_flutter/src/presentation/blocs/blocs.dart';

import '../../model/book.dart';

class ListCharacter extends StatefulWidget {
  const ListCharacter({super.key});

  @override
  State<ListCharacter> createState() => _ListCharacterState();
}

class _ListCharacterState extends State<ListCharacter> {
  final titleStyle = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookBloc>(context).add(FetchBooks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is BookLoaded) {
        return _buildBookList(state.books);
      } else if (state is BookError) {
        return Center(
          child: Text('Error: {$state.message}'),
        );
      } else {
        return const Center(
          child: Text('Unexpected state'),
        );
      }
    });
  }

  Widget _buildBookList(List<Book> books) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: books.map((book) => _buildBookItem(book)).toList(),
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Image.network(
            book.imageUrl, // Usa la URL de la imagen del libro
            height: 150.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          book.title,
          style: titleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          book.author,
          style: const TextStyle(color: Colors.white70, fontSize: 12.0),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
