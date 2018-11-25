import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Quote {
  Uuid id;
  String title;
  String text;
  String source;
  bool isMemorized;


  Quote(title, text, source, isMemorized) {
    this.id = new Uuid();
    this.title = title;
    this.text = text;
    this.source = source;
    this.isMemorized = isMemorized;
  }

  toJsonEncodeable() {
    Map<String, dynamic> m = new Map();
    m['title'] = this.title;
    m['text'] = this.text;
    m['source'] = this.source;
    m['isMemorized'] = this.isMemorized;
    return m;
  }
}


class QuoteList {
  List<Quote> _list = [];
  final LocalStorage storage = new LocalStorage('quote-memorizer'); 
  bool isReady = false;

  QuoteList() {
    storage.ready.then((ready) {
      print('storage is ready: $ready');
      isReady = ready;
      loadList();
      if (_list == null) {
        autopupulateList();
        saveList();
      }
      print('list length: ${_list.length}');
    });

  }

  addQuote(Quote q) {
    _list.add(q);
    saveList();
  }

  removeQuote(Uuid id) {
    _list.removeWhere((el) {
      return el.id == id;
    });
    saveList();
  }

  get length {
    return _list.length;
  }

  getQuotes() {
    return _list;
  }

  saveList() {
    var jsonString = _list.map((el) => el.toJsonEncodeable()).toList();
    storage.ready.then((e) => print('storage status: $e'));
    storage.setItem('quotes', jsonString);
  }

  // sets _list to null on error
  loadList() {
    var data = storage.getItem('quotes');
    print('loaded quotes from storage: $data');
    if (data == null) {
      print('no quotes found. Autopopulating...');
      autopupulateList();
      saveList();
      return;
    }
    try {
      List<dynamic> jsonList = data;
      _list = jsonList.map((e) {
        return new Quote(e['title'], e['text'], e['source'], e['isMemorized']);
      }).toList();  
    } catch (e) {
      print(e);
      _list = null;
    }
  }

  autopupulateList() {
    _list = [
      new Quote(
        'Sacrament Prayer - Bread',
        'O God, the Eternal Father, we ask thee in the name of thy Son, Jesus Christ, to bless and sanctify this bread to the souls of all those who partake of it, that they may eat in remembrance of the body of thy Son, and witness unto thee, O God, the Eternal Father, that they are willing to take upon them the name of thy Son, and always remember him and keep his commandments which he has given them; that they may always have his Spirit to be with them. Amen.', 
        'D&C 20:77', 
        true),
      new Quote( 
        'Sacrament Prayer - Water',
        'O God, the Eternal Father, we ask thee in the name of thy Son, Jesus Christ, to bless and sanctify this wine to the souls of all those who drink of it, that they may do it in remembrance of the blood of thy Son, which was shed for them; that they may witness unto thee, O God, the Eternal Father, that they do always remember him, that they may have his Spirit to be with them. Amen.', 
        'D&C 20:79', 
        false),
      new Quote(
        'quote3', 
        'text goes here', 
        'source', 
        true),
      new Quote(
        'quote4', 
        'text goes here', 
        'source', 
        false),
      new Quote(
        'quote5', 
        'text goes here', 
        'source', 
        false),
    ];
  }
}

