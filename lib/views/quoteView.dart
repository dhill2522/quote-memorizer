import 'package:flutter/material.dart';
import '../quotes.dart';

class QuoteView extends StatefulWidget {
  final Quote quote;
  final QuoteList quoteList;

  QuoteView ({Key key, @required this.quote, @required this.quoteList}) : super(key: key);
  
  @override
  QuoteState createState() => new QuoteState(quote: quote, quoteList: quoteList);

}
class QuoteState extends State<QuoteView> {
  final Quote quote;
  final QuoteList quoteList;

  QuoteState ({Key key, @required this.quote, @required this.quoteList}) : super();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quote.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Delete quote',
            onPressed: () {
              quoteList.removeQuote(quote.id);
              Navigator.pop(context);
            },
          )
        ],
      ),
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

