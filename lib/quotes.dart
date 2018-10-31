import 'package:uuid/uuid.dart';

class Quote
{
  Uuid id;
  String title;
  String text;
  String source;
  String shortText;
  bool isMemorized;


  Quote(title, text, source, isMemorized)
  {
    this.id = new Uuid();
    this.title = title;
    this.text = text;
    this.source = source;
    this.isMemorized = isMemorized;
    if (text.split(' ').length > 10) {
      this.shortText = text.split(' ').sublist(0, 10).join(' ') + '...';
    } else {
      this.shortText = text;
    }
  }
}

List<Quote> getQuotes() {
  List<Quote>list = new List<Quote>(5);
  list = [
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
  return list;
}