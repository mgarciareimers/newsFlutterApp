import 'package:flutter/material.dart';

import 'package:newsapp/src/pages/tabs_page.dart';
import 'package:newsapp/src/theme/dark_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: TabsPage(),
    );
  }
}