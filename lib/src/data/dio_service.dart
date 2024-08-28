import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_flutter/src/model/book.dart';

class DioService {
  static final String _baseUrl = dotenv.env["BASE_URL"]!;

  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'x-rapidapi-key': "abc9224d5fmsh0359bf10701a7e4p1f93edjsnefcb691a457c",
        'x-rapidapi-host': "all-books-api.p.rapidapi.com",
      },
    ),
  );

  Future<List<Book>> fetchBooks() async {
    try {
      Response response;
      response =
          await _dio.get("https://all-books-api.p.rapidapi.com/getBooks");
      print(response.data.toString());
      final List<dynamic> data = response.data;
      print(data.toList().toString());
      return data.map((item) => Book.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }
}
