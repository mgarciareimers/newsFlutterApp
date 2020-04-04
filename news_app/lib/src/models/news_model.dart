// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:newsapp/src/models/article_model.dart';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  String status;
  int totalResults;
  List<ArticleModel> articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json['status'],
    totalResults: json['totalResults'],
    articles: List<ArticleModel>.from(json['articles'].map((x) => ArticleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}