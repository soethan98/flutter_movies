import 'package:flutter_movies/data/movie.dart';

class MovieResponse {
  final List<Movie> movieResponse;

  MovieResponse({
    this.movieResponse,
  });


  factory MovieResponse.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Movie> movieList = list.map((i) => Movie.fromJson(i)).toList();

    return new MovieResponse(movieResponse: movieList);
  }
}
