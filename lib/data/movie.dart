class Movie {
  String id;

  final String poster;
  final String overview;
  final String title;
  final String voteAverage;

  Movie({this.id, this.poster, this.title, this.overview, this.voteAverage});



  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'].toString(),
        title: json['original_title'],
        overview: json['overview'],
        poster: json['poster_path'],
        voteAverage: json['vote_average'].toString());
  }


}
