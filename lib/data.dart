import 'dart:convert';

import 'package:app_ex2_2/data.dart';
import 'package:app_ex2_2/data.dart';
import 'package:app_ex2_2/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

//presentation layer
class ArticlesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticlesScreenState();
  }
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late Future<List<Article>> article;

  @override
  void initState() {
    super.initState();
    article = RemoteDataSource().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: article,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _Articles = (snapshot.data as List<Article>);

              return ListView.builder(
                  itemCount: _Articles.length,
                  itemBuilder: (context, index) =>
                      ArticleListItem(_Articles[index]));
            } else if (snapshot.hasError) {
              return Container(
                child: Center(child: Text('has error')),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ArticleListItem extends StatelessWidget {
  var _Article;

  ArticleListItem(this._Article);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Center(
          child: InkWell(
        child: Card(
          child: Column(
            children: [
              Container(
                child: Image.network(_Article.picture),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _Article.title,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArticleDetailsScreen(articleDetails: _Article),
            ),
          );
        },
      )),
    );
  }
}

//data layer

class Article {
  String title;
  String picture;
  String content;
  String id;

  Article(
    this.id,
    this.content,
    this.picture,
    this.title,
  );

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['id'],
      json['content'],
      json['picture'],
      json['title'],
    );
  }
}

//Data layer
class RemoteDataSource {
  Future<List<Article>> fetchArticles() async {
    var response = await http.get(
        Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var list = (jsonResponse as List);
      var newList = list.map((item) => Article.fromJson(item)).toList();

      return newList;
    } else {
      throw Exception('Can not fetch article');
    }
  }
}
