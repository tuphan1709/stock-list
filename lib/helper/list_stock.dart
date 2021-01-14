import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_final/models/company_detail_model.dart';
import 'package:stock_final/models/model_name_stock.dart';

class StockNameHome {
  List<Stock> stocks = [];

  Future<void> getStockName(String country) async {
    String datastock =
        //"https://api.twelvedata.com/stocks?source=docs";
        //"https://api.twelvedata.com/stocks?symbol=AAPL&source=docs";
        "https://api.twelvedata.com/stocks?country=$country&type=Common%20Stock&source=docs";
    var response = await http.get(datastock);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["data"].forEach((element) async {
        //if (element["country"] == country) {
        if (element["symbol"] != null && element["name"] != null) {
          Stock stockModel = Stock(
            symbol: element['symbol'],
            name: element['name'],
            //price: jsonDatas['05. price']
            // currency: element['currency'],
            // exchange: element['exchange'],
            // country: element['country'],
            // type: element['type']
          );

          stocks.add(stockModel);
        }
        //}
      });
    }
  }
}

class StockPriceByCountry {
  List<Stock> stocks = [];

  Future<void> getStockName(String country) async {
    String datastock =
        "https://api.twelvedata.com/stocks?country=$country&type=Common%20Stock&source=docs";

    var response = await http.get(datastock);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["data"].forEach((element) {
        if (element["symbol"] != null && element["name"] != null) {
          Stock stockModel = Stock(
            symbol: element['symbol'],
            name: element['name'],
            // currency: element['currency'],
            // exchange: element['exchange'],
            // country: element['country'],
            // type: element['type']
          );

          stocks.add(stockModel);
        }
      });
    }
  }
}

class StockDetail {
  List<detailCompany> stocks = [];

  Future<void> getStockDetail(String portfolio) async {
    String datastock =
        "https://api.twelvedata.com/quote?symbol=$portfolio&apikey=b52dca44fd2a4c448dc7076d4322e9df&source=docs";

    var response = await http.get(datastock);

    var jsonData = jsonDecode(response.body);

    String dataprice =
        "https://api.twelvedata.com/price?symbol=$portfolio&apikey=b52dca44fd2a4c448dc7076d4322e9df&source=docs";

    var responses = await http.get(dataprice);

    var jsonDatas = jsonDecode(responses.body);

    if (jsonData["symbol"] != null && jsonData["name"] != null) {
      detailCompany stockModel = detailCompany(
          sympol: jsonData['symbol'],
          exchange: jsonData['exchange'],
          currency: jsonData['currency'],
          open: jsonData['open'],
          high: jsonData['high'],
          low: jsonData['low'],
          close: jsonData['close'],
          volume: jsonData['volume'],
          previousClose: jsonData['previous_close'],
          change: jsonData['change'],
          percentChange: jsonData['percent_change'],
          averageVolume: jsonData['average_volume'],
          //price
          price: jsonDatas['price']
          // currency: element['currency'],
          // exchange: element['exchange'],
          // country: element['country'],
          // type: element['type']
          );

      stocks.add(stockModel);
    }
    ;
  }
}
