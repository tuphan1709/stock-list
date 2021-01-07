class Stock{
  final String symbol;
  final String name;
  final String currency;
  final String exchange;
  final String country;
  final String type;

  Stock(
      {this.symbol, this.name, this.currency, this.country, this.exchange, this.type
      });


  factory Stock.fromJson(Map<String, dynamic> json){
    return Stock(symbol: json['symbol'],
        name: json['name'],
        currency : json['currency'],
        country : json['country'],
        exchange : json['exchange'],
        type : json['type'],);

  }
}