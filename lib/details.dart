import 'package:flutter/material.dart';
import 'data.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key, required this.articleDetails});
  final Article articleDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleDetails.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Card(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
                    child: Image.network(
                      articleDetails.picture,
                      fit: BoxFit.cover,
                      height: 85.0,
                      width: 85.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(articleDetails.content,
                                style: TextStyle(fontSize: 20))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
