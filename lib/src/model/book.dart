import 'dart:convert';

class Book {
  final String title;
  final String author;
  final String description;
  final String imageUrl;

  // Constructor
  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
  });

  //Create a factoryu to made a Book for a Json
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['bookTitle'] as String,
      author: json['bookAuthor'] as String,
      description: json['bookDescription'] as String,
      imageUrl: json['bookImage'] as String,
    );
  }

  // this method converts the model to a JSON
  Map<String, dynamic> toJson() {
    return {
      'bookTitle': title,
      'bookAuthor': author,
      'bookDescription': description,
      'bookImage': imageUrl,
    };
  }

  // And this creates a List of books about one list of Json
  static List<Book> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Book.fromJson(json)).toList();
  }
}
