import 'package:flutter/material.dart';

import 'package:newsapp/src/models/article_model.dart';
import 'package:newsapp/src/theme/dark_theme.dart';

class NewsList extends StatelessWidget {
  final List<ArticleModel> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _NewWidget(dailyNew: this.news[index], index: index);
      }
    );
  }
}

class _NewWidget extends StatelessWidget {
  final ArticleModel dailyNew;
  final int index;

  const _NewWidget({ @required this.dailyNew, @required this.index });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TopBarCard(dailyNew: this.dailyNew, index: index),
        _TitleCard(dailyNew),
        _ImageCard(dailyNew),
        _BodyCard(dailyNew),
        _ButtonsCard(),
        SizedBox(height: 15),
        Divider(),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final ArticleModel dailyNew;
  final int index;

  const _TopBarCard({ @required this.dailyNew, @required this.index });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10, top: 15),
      child: Row(
        children: <Widget>[
          Text('${ index + 1}. ', style: TextStyle(color: darkTheme.accentColor)),
          Text('${ dailyNew.source.name }'),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {

  final ArticleModel dailyNew;

  const _TitleCard(this.dailyNew);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(this.dailyNew.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }
}

class _ImageCard extends StatelessWidget {

  final ArticleModel dailyNew;

  const _ImageCard(this.dailyNew);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: dailyNew.urlToImage != null ? (
        FadeInImage(
          placeholder: AssetImage('assets/img/giphy.gif'),
          image: NetworkImage(dailyNew.urlToImage),
        )
      ) : (
        Image(image: AssetImage('assets/img/no-image.png'))
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {

  final ArticleModel dailyNew;

  const _BodyCard(this.dailyNew);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(dailyNew != null ? dailyNew.description : ''),
    );
  }
}

class _ButtonsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 7),
            child: ClipOval(
              child: Material(
                color: darkTheme.accentColor,
                child: InkWell(
                  splashColor: Colors.white,
                  child: SizedBox(width: 38, height: 38, child: Icon(Icons.star_border)),
                  onTap: () {},
                ),
              ),
            ),
          ),
          Container(
          padding: EdgeInsets.only(left: 7),
            child: ClipOval(
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.white,
                  child: SizedBox(width: 38, height: 38, child: Icon(Icons.more_horiz)),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
