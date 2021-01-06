import 'package:anthortest/app/modules/home/repositories/movie_repository.dart';
import 'package:anthortest/app/shared/database_local/database_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_movie_cubit.freezed.dart';
part 'edit_movie_state.dart';

class EditMovieCubit extends Cubit<EditMovieState> {
  final MovieRepository _repository;
  EditMovieCubit(this._repository) : super(EditMovieState.loadInitial());

  void edit(MovieData movie) async {
    emit(EditMovieState.loadLoading());

    final result = await _repository.edit(movie: movie);
    result.fold(
      (error) => emit(EditMovieState.loadFailure(error)),
      (data) => emit(EditMovieState.loadSucess()),
    );
  }
}