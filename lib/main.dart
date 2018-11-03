import 'package:flutter/material.dart';
import 'views/quotesList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Restoration Memorizer',
      theme: new ThemeData(primarySwatch: Colors.green,),
      // home: new MyHomePage(title: 'Restoration Memorizer'),

      home: QuoteListView(),
    );
  }
}