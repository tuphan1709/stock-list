import 'dart:convert';

import 'package:stock_final/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:stock_final/models/company_new_model.dart';

class News {
  List<ArticleModel> news = [];
  Future<void> getNew() async {
    const url =
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f3f4556cae7845b78feaef4c8bc9ce1e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNew(String categories) async {
    String url =
        "https://newsapi.org/v2/everything?q=$categories&from=2021-01-07&to=2021-01-07&sortBy=popularity&apiKey=f3f4556cae7845b78feaef4c8bc9ce1e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

class StockNews {
  List<CompanyPortfolio> news = [];
  Future<void> getNew(String company) async {
    String url =
        "https://newsapi.org/v2/everything?q=$company&from=2021-01-07&to=2021-01-07&sortBy=popularity&apiKey=f3f4556cae7845b78feaef4c8bc9ce1e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          CompanyPortfolio articleModel = CompanyPortfolio(
            category: element['title'],
            headline: element['author'],
            imageUrl: element['description'],
            related: element['urlToImage'],
            url: element['url'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
