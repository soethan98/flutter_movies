import 'package:flutter/material.dart';
import 'package:flutter_movies/data/movie.dart';
import 'package:flutter_movies/data/api.dart';
import 'package:flutter_movies/data/movie_response.dart';

var image_url = 'https://image.tmdb.org/t/p/w500/';
Color mainColor = const Color(0xff3C3261);

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    // TODO: implement createState
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: FutureBuilder<MovieResponse>(
          future: api.fetchMovie(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListView(snapshot.data.movieResponse);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _buildListView(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, i) {
        return _buildMovieItem(movies[i]);
      },
    );
  }

  Widget _buildMovieItem(Movie movie) {
    return new Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 8.0, bottom: 16.0),
              child: new Container(
                child: new Container(
                  width: 70.0,
                  height: 80.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  image: new DecorationImage(
                      image: new NetworkImage(image_url + movie.poster),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Expanded(
                child: new Container(
              margin: EdgeInsets.only(left: 16.0),
              child: new Column(
                children: [
                  new Text(
                    movie.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  new Text(
                    movie.overview,
                    maxLines: 3,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.redAccent),
                  Text(movie.voteAverage)
                ],
              ),
            )
          ],
        ),
        new Container(
          width: 400.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.only(left: 16.0),
        )
      ],
    );
  }
}
