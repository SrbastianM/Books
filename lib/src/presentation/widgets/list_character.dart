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
  final descriptionStyleMobile = const TextStyle(
    fontSize: 8.0,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );

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
            ? Column(
                children: [
                  _buildBookMobileList(state.books),
                  _buildBookDetailList(state.books)
                ],
              )
            : Column(children: [_buildBookWebList(state.books)]);
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
            child: _buildBookCoverWeb(book),
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
                child: _buildBookCoverMobile(book),
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

  Widget _buildBookCoverMobile(Book book) {
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

  Widget _buildBookDetailList(List<Book> books) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 450,
      width: screenWidth,
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return _buildBookDetail(book);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookDetail(Book book) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      height: 100,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(66, 43, 43, 43),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                  ),
                ], borderRadius: BorderRadius.circular(6.0)),
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 100,
                  width: 60,
                  child: Image.network(
                    book.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    book.title,
                    style: titleStyleMobile,
                  ),
                  SizedBox(
                    width: 150,
                    child: RichText(
                      text: TextSpan(
                          text: book.description,
                          style: descriptionStyleMobile),
                      maxLines: 4,
                    ),
                  )
                ],
              )
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBookCoverWeb(Book book) {
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
