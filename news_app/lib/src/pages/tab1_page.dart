import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    final scrollController = ScrollController();
    scrollController.addListener(() {
      final position = scrollController.position.pixels;
      final maxPosition = scrollController.position.maxScrollExtent;

      if (position >= 0.95 * maxPosition && position <= 0.96 * maxPosition) {
        newsService.itemScrollTopHeadLines();
      }
    });

    return Scaffold(
      body: newsService.headlines.length == 0 ?
        Center(child: CircularProgressIndicator()) :
        NewsList(newsService.headlines, scrollController),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
