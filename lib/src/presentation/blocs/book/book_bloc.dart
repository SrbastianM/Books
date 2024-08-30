import 'package:bloc/bloc.dart';
import 'package:web_flutter/src/data/dio_service.dart';
import 'package:web_flutter/src/presentation/blocs/book/book_event.dart';
import 'package:web_flutter/src/presentation/blocs/book/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final DioService dioService;

  BookBloc({required this.dioService}) : super(BookLoading()) {
    on<FetchBooks>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    emit(BookLoading());

    try {
      final books = await dioService.fetchBooks();
      final bookDetails = await dioService.fetchBooks();
      emit(BookLoaded(books, bookDetails));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
