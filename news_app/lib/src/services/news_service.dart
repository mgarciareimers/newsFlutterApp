import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/article_model.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_model.dart';

class NewsService with ChangeNotifier {
  final _API_KEY = 'f12a44e0bd6045988bb6670e9e9ecb1e';
  final _COUNTRY = 'cu';
  final _PAGE_SIZE = 20;
  final _TOP_HEADLINES = 'top-headlines';
  final _URL_NEWS = 'https://newsapi.org/v2/';

  bool _isLoading = true;
  List<ArticleModel> headlines = [];
  int headlinesTotalResults = 0;
  int categoriesTotalResults = 0;
  int headlinesCurrentPageNumber = 1;
  int categoriesCurrentPageNumber = 1;
  String _selectedCategory = 'business';

  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.basketballBall, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<ArticleModel>> categoryArticles = {};

  // Constructor;
  NewsService() {
    this.getTopHeadlines(1);

    this.categories.forEach((category) {
      this.categoryArticles[category.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory, 1);
  }

  // Get/set selectedCategory.
  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this._isLoading = true;

    // Get articles by categories.
    this.getArticlesByCategory(this._selectedCategory, 1);

    this._isLoading = false;
    notifyListeners();
  }

  List<ArticleModel> get selectedCategoryArticles => this.categoryArticles[this.selectedCategory];
  bool get isLoading => this._isLoading;

  itemScrollTopHeadLines() {
    final pageNumber = (this.headlines.length ~/ this._PAGE_SIZE) + 1;

    if (this.headlinesTotalResults <= this.headlines.length || pageNumber != this.headlinesCurrentPageNumber) {
      this._isLoading = false;
      return;
    }

    this.getTopHeadlines(this.headlinesCurrentPageNumber);
  }

  itemScrollGetArticlesByCategory(String category) {
    final pageNumber = (this.categoryArticles[category].length ~/ this._PAGE_SIZE) + 1;

    if (this.categoriesTotalResults <= this.categoryArticles[category].length || pageNumber != this.categoriesCurrentPageNumber) {
      this._isLoading = false;
      return;
    }

    this.getArticlesByCategory(category, this.categoriesCurrentPageNumber);
  }

  getTopHeadlines(int pageNumber) async {
    if (pageNumber == 1) {
      this.headlines.clear();
      this.headlinesCurrentPageNumber = pageNumber;
    }

    this.headlinesCurrentPageNumber++;

    final url = '${this._URL_NEWS}${this._TOP_HEADLINES}?apiKey=${this._API_KEY}&country=${this._COUNTRY}&${this._PAGE_SIZE}&page=${pageNumber}';
    final response = await http.get(url);

    final news = newsModelFromJson(response.body);

    this.headlinesTotalResults = news.totalResults;
    this.headlines.addAll(news.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category, int pageNumber) async {
    if (pageNumber == 1) {
      this.categoryArticles[category].clear();
      this.categoriesCurrentPageNumber = pageNumber;
    }

    this.categoriesCurrentPageNumber++;
    
    final url = '${this._URL_NEWS}${this._TOP_HEADLINES}?apiKey=${this._API_KEY}&category=${category}&country=${this._COUNTRY}&pageSize=${this._PAGE_SIZE}&page=${pageNumber}';

    final response = await http.get(url);

    final news = newsModelFromJson(response.body);

    this.categoriesTotalResults = news.totalResults;
    this.categoryArticles[category].addAll(news.articles);

    this._isLoading = false;
    notifyListeners();
  }
}