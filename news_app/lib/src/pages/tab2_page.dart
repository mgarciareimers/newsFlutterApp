import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/theme/dark_theme.dart';
import 'package:newsapp/src/widgets/news_list.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    final scrollController = ScrollController();
    scrollController.addListener(() {
      final position = scrollController.position.pixels;
      final maxPosition = scrollController.position.maxScrollExtent;

      if (position >= 0.95 * maxPosition && position <= 0.96 * maxPosition) {
        newsService.itemScrollGetArticlesByCategory(newsService.selectedCategory);
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            CategoriesListView(),
            Expanded(
              child: newsService.isLoading ?
              Center(child: CircularProgressIndicator()) :
              NewsList(newsService.selectedCategoryArticles, scrollController),
            )
          ]
        ),
      ),
    );
  }
}

class CategoriesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 95,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 10),
              width: 80,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    _CategoryButton(categories[index]),
                    SizedBox(height: 5),
                    Text(categories[index].name, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final CategoryModel category;

  const _CategoryButton( this.category );

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(category.icon, color: newService.selectedCategory == category.name ? darkTheme.accentColor : Colors.black87),
      ),
    );
  }
}
