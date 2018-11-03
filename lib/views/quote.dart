import 'package:flutter/material.dart';
import '../quotes.dart';

class QuoteView extends StatefulWidget {
  final Quote quote;

  QuoteView ({Key key, @required this.quote}) : super(key: key);
  
  @override
  QuoteState createState() => new QuoteState(quote: quote);

}
class QuoteState extends State<QuoteView> {
  final Quote quote;

  QuoteState ({Key key, @required this.quote}) : super();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(quote.title)),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(quote.text + '\n'),
              subtitle: Text(quote.source),
            ),
            ButtonTheme.bar(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    quote.isMemorized = !quote.isMemorized;
                  });
                },
                child: quote.isMemorized ? Text('Mark as unmemorized') : Text('Mark as memorized'),
              )
            )
          ]
        ),
      ),
    );
  }
}

