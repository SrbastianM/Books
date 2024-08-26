import 'package:bloc/bloc.dart';

class DetailCubit extends Cubit<String> {
  DetailCubit() : super('no-details');

  void setUsername(String username) {
    emit(username);
  }
}
