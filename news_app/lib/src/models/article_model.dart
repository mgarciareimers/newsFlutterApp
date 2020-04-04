import 'package:newsapp/src/models/source_model.dart';

class ArticleModel {
  SourceModel source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    source: SourceModel.fromJson(json['source']),
    author: json['author'] == null ? null : json['author'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
    urlToImage: json['urlToImage'],
    publishedAt: DateTime.parse(json['publishedAt']),
    content: json['content'] == null ? null : json['content'],
  );

  Map<String, dynamic> toJson() => {
    'source': source.toJson(),
    'author': author == null ? null : author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt.toIso8601String(),
    'content': content == null ? null : content,
  };
}