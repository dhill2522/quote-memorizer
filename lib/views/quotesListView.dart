import 'package:flutter/material.dart';
import 'quoteView.dart';
import 'addQuoteView.dart';
import '../quotes.dart';


class QuotesState extends State<QuoteListView> {
  final _quotesList = new QuoteList();

  Widget _buildQuotesList() {
    return ListView.builder(
      itemCount: _quotesList.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildRow(_quotesList.getQuotes()[i]);
      }
    );
  }

  Widget _buildRow(Quote quote) {
    if (quote.title == null) {
      // There may be nulls at times, this takes care of them
      return Container();
    }
    return Container(
      child: ListTile(
        title: Text(quote.title + '\n' + quote.source, maxLines: 2, overflow: TextOverflow.fade,),
        subtitle: Text(quote.text, overflow: TextOverflow.ellipsis, maxLines: 2,),
        trailing: Container(
          child: quote.isMemorized ? Icon(Icons.check) : Icon(Icons.clear),
        ),
          
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuoteView(quote: quote, quoteList: _quotesList,)),
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.green))
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Priesthood Quotes List (${this._quotesList.length})'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add New Quote',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuoteView(quoteList: _quotesList)));
            } 
          )
        ],
      ),
      body: _buildQuotesList(),
    );
  }
}


class QuoteListView extends StatefulWidget {
  @override
  QuotesState createState() => new QuotesState();
}
