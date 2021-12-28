import 'dart:convert';
import 'package:day7_demo2/model/model_movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: ScreenApi(),
    );
  }
}

class ScreenApi extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ScreenApi> {
  late MoviesArray _moviesArray;
  final ScrollController _controllerLoading = ScrollController();
  final int increment = 10;
  bool isLoading = false;
  late Movies _movies;
  var withScreen;
  int records = 0;
  double pos = 0;
  late String linkImage = 'https://www.themoviedb.org/t/p/w220_and_h330_face';

  Future fetchDataFromApi() async {
    var jsonData = await http.get(Uri.parse(
        "http://api.themoviedb.org/3/movie/popular?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page=1"));
    setState(() {
      var fetchData = jsonDecode(jsonData.body);
      _moviesArray = new MoviesArray.fromJson(fetchData);
    });
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });
    await new Future.delayed(const Duration(seconds: 1));
    if (records >= _moviesArray.movies.length) {
      return;
    }
    records += increment;
    // _moviesArray.movies.addAll(List.generate(increment, (index) => _moviesArray.movies.length + index));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadMore();
    fetchDataFromApi();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('API'),
          centerTitle: true,
        ),
        body: LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => _loadMore(),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text('Tổng số :' + records.toString())),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: GridView.builder(
                    controller: _controllerLoading,
                    itemCount: _moviesArray.movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      withScreen = MediaQuery.of(context).size.width;
                      _movies = Movies(
                          id: _moviesArray.movies[index].id,
                          original_title:
                              _moviesArray.movies[index].original_title,
                          poster_path: _moviesArray.movies[index].poster_path,
                          vote_average: _moviesArray.movies[index].vote_average,
                          vote_count: _moviesArray.movies[index].vote_count);
                      return _myItem(index, withScreen, _movies);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10),
                  ),
                ),
              ],
            )));
  }

  Widget _myItem(index, withScreen, _movies) {
    String getlink = linkImage + _movies.poster_path;
    return Card(
      child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_movies.original_title.toString()),
                duration: Duration(milliseconds: 500),
              ),
            );
          },
          child: Container(
            child: Image.network(
              getlink,
              fit: BoxFit.cover,
              height: 40.0,
              width: 40.0,
            ),
          )),
    );
  }
}
