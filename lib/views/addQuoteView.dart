import 'package:flutter/material.dart';
import '../quotes.dart';

class AddQuoteView extends StatefulWidget {
  final QuoteList quoteList;
  AddQuoteView ({Key key, @required this.quoteList}) : super(key: key);

  @override
  AddQuoteState createState() => new AddQuoteState(quoteList: quoteList);
}

class AddQuoteState extends State<AddQuoteView> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController tTitle = TextEditingController();
  final TextEditingController tSource = TextEditingController();
  final TextEditingController tText = TextEditingController();

  Quote _quote;
  QuoteList quoteList;
  String newSource = '';

  AddQuoteState({Key key, @required this.quoteList}) : super();

  onAddQuote() {
    if (this.tTitle.text != '') {
      this._quote = new Quote(this.tTitle.text, this.tText.text, this.tSource.text, false);
      this.quoteList.addQuote(this._quote);
    }
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a new quote'),),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new TextField(
                controller: tTitle,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Enter Title',
                  labelText: 'Title:'
                ),
              ),
              new TextField(
                controller: tSource,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Enter Source',
                  labelText: 'Source:'
                ),
              ),
              new TextField(
                controller: tText,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Enter quote',
                  labelText: 'Quote:'
                ),
              ),
              new RaisedButton(
                onPressed: () {
                  this.onAddQuote();
                },
                child: Text('Add Quote'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    tTitle.dispose();
    tSource.dispose();
    tText.dispose();
    super.dispose();
  }
}