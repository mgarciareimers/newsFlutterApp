import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/article_model.dart';
import 'package:newsapp/src/models/news_model.dart';

class NewsService with ChangeNotifier {
  final _URL_NEWS = 'https://newsapi.org/v2/';
  final _TOP_HEADLINES = 'top-headlines';
  final _API_KEY = 'f12a44e0bd6045988bb6670e9e9ecb1e';

  List<ArticleModel> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    final url = '${this._URL_NEWS}${this._TOP_HEADLINES}?apiKey=${this._API_KEY}&country=us';
    final response = await http.get(url);

    final news = newsModelFromJson(response.body);

    this.headlines.addAll(news.articles);

    notifyListeners();
  }
}