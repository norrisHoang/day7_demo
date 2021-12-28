import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: ScreenListView(),
    );
  }
}

class ScreenListView extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ScreenListView> {
  ScrollController _controllerLoading = ScrollController();
  List<int> _listItem = [100];
  final int increment = 10;
  bool isLoading = false;
  var withScreen;
  int records = 0;
  double pos = 0;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });
    await new Future.delayed(const Duration(seconds: 1));
    if (_listItem.length > 100) {
      return;
    }
    records += increment;
    _listItem
        .addAll(List.generate(increment, (index) => _listItem.length + index));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('List Of Images'),
          centerTitle: true,
        ),
        body: LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => _loadMore(),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text('Tổng số :' + records.toString())),
                      Expanded(
                        flex: 2,
                        child: const Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: ListView.builder(
                    controller: _controllerLoading,
                    itemCount: _listItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      withScreen = MediaQuery.of(context).size.width;
                      return _myItem(index, withScreen);
                    },
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _loadMore();
                              },
                              child: Text('Jump Controller'),
                            )),
                      ],
                    )),
              ],
            )));
  }

  Widget _myItem(index, withScreen) {
    return Card(
      child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(index.toString()),
                duration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(withScreen / 2, 20, 0, 20),
            child: Text(index.toString()),
          )),
    );
  }
}
