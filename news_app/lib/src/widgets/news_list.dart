import 'package:flutter/material.dart';

import 'package:newsapp/src/models/article_model.dart';

class NewsList extends StatelessWidget {
  final List<ArticleModel> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(this.news[index].title);
      }
    );
  }
}
