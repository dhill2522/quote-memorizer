import 'package:flutter/material.dart';
import 'quote.dart';
import '../quotes.dart';

class QuotesState extends State<QuoteListView> {
  final _qoutesList = getQuotes();

  Widget _buildQuotesList() {
    return ListView.builder(
      itemCount: _qoutesList.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // if (i.isOdd) return Divider();
        return _buildRow(_qoutesList[i]);
      }
    );
  }

  Widget _buildRow(Quote quote) {
    return Container(
      child: ListTile(
        title: Text(quote.title + '\n' + quote.source, maxLines: 2, overflow: TextOverflow.fade,),
        subtitle: Text(quote.text, overflow: TextOverflow.ellipsis, maxLines: 2,),
        trailing: Container(
          child: quote.isMemorized ? Icon(Icons.check) : Icon(Icons.clear),
        ),
          
        // trailing: quote.isMemorized ? Icon(Icons.check) : new Icon(Icons.clear),
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuoteView(quote: quote,)),
          );
        },
      ),
      decoration: new BoxDecoration(
        border: new Border(bottom: new BorderSide(color: Colors.green))
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Priesthood Quotes List')
      ),
      body: _buildQuotesList(),
    );
  }
}


class QuoteListView extends StatefulWidget {
  @override
  QuotesState createState() => new QuotesState();
}
