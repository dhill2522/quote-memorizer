class Quote
{
  String text;
  String source;
  bool isMemorized;

  Quote(text, source, isMemorized)
  {
    this.text = text;
    this.source = source;
    this.isMemorized = isMemorized;
  }
}

List<Quote> getQuotes() {
  List<Quote>list = new List<Quote>(50);
  list = [
    new Quote('quote1', 'source', false),
    new Quote('quote2', 'source', false),
    new Quote('quote3', 'source', false),
    new Quote('quote4', 'source', false),
    new Quote('quote5', 'source', false),
  ];
  return list;
}