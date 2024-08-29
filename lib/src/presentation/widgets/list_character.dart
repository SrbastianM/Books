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
  final titleStyleMobile = const TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookBloc>(context).add(FetchBooks());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is BookLoaded) {
        return screenWidth < 600
            ? _buildBookMobileList(state.books)
            : _buildBookWebList(state.books);
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

  Widget _buildBookWebList(List<Book> books) {
    return Container(
      height: 250.0,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildBookItemWeb(book),
          );
        },
      ),
    );
  }

  Widget _buildBookMobileList(List<Book> books) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Text(
          "Portraits",
          style: titleStyle,
        ),
        SizedBox(
          height: 220.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 16.0, top: 10.0),
                child: _buildBookItemMobile(book),
              );
            },
          ),
        ),
        const Divider(
          thickness: 1,
          color: Color.fromARGB(255, 62, 62, 62),
        ),
      ],
    );
  }

  Widget _buildBookItemMobile(Book book) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.only(
          left: 20.0,
        )),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            book.imageUrl ?? "Not Found", // Usa la URL de la imagen del libro
            fit: BoxFit.cover,
            height: 200,
            width: 100,
          ),
        ),
      ],
    );
  }

  Widget _buildBookItemWeb(Book book) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          height: 200.0, // Ajusta la altura según sea necesario
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contenedor para la imagen
                SizedBox(
                  width: 150.0, // Ajusta el ancho según sea necesario
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.network(
                      book.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                // Contenedor para la información del libro
                SizedBox(
                  width: 200.0, // Ajusta el ancho según sea necesario
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        book.author,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14.0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            book.description,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14.0),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
