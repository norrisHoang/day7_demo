class MoviesArray{
  final List<Movies> movies;

  MoviesArray({required this.movies});

  factory MoviesArray.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['results'] as List;
    print(list.runtimeType);
    List<Movies> dataList = list.map((i) => Movies.fromJson(i)).toList();


    return MoviesArray(
        movies: dataList
    );
  }
}


class Movies {
  late final int id;
  late final String original_title;
  late final String poster_path;
  late final double vote_average;
  late final int vote_count;

  Movies(
      {required this.id,
      required this.original_title,
      required this.poster_path,
      required this.vote_average,
      required this.vote_count});

  factory Movies.fromJson(Map<String, dynamic> parsedJson) {
    return Movies(
        id: parsedJson['id'],
        original_title: parsedJson['original_title'],
        poster_path: parsedJson['poster_path'],
        vote_average: parsedJson['vote_average'],
        vote_count: parsedJson['vote_count']);
  }
}
