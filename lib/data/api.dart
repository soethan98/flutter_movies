import 'dart:async';
import 'movie_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Api {

  static Api _api;

  Api._createInstance();

  factory Api() {
    if (_api == null) {
      _api = Api._createInstance();
    }
    return _api;
  }
  Future<MovieResponse> fetchMovie() async {
    final response = await http.get(
        'http://api.themoviedb.org/3/discover/movie?api_key=c442c0f60ec3c4195239967c7f676937');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load Movies');
    }
  }
}
