import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(color: Colors.red),
        Container(color: Colors.green),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('For You')),
          BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Headers')),
        ],
      currentIndex: navigationModel.currentPage,
      onTap: (index) => navigationModel.currentPage = index,
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  // Current page get/set.
  int get currentPage => this._currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners(); // Update widgets.
  }

  // Current page get.
  PageController get pageController => this._pageController;


}