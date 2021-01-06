import 'package:anthortest/app/models/movie_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OmdbRepository {
  final Dio client;
  OmdbRepository(this.client);

  Future<Either<String, List<MovieModel>>> searchByText({String text}) async {
    try {
      final result = await client.get("&s=$text");

      List<MovieModel> movies = [];
      for (var item in result.data["Search"]) {
        var movie = MovieModel.fromJson(item);
        movies.add(movie);
      }

      return Right(movies);
    } on DioError catch (e) {
      return Left("${e.message}");
    }
  }
}