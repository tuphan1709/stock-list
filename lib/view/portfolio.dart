import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stock_final/helper/list_stock.dart';
import 'package:stock_final/helper/news.dart';
import 'package:stock_final/models/company_detail_model.dart';
import 'package:stock_final/models/company_new_model.dart';
import 'package:stock_final/view/article_view.dart';

class portfolioCompany extends StatefulWidget {
  final String portfolio;
  final String nameCompany;
  portfolioCompany({this.portfolio, this.nameCompany});
  @override
  _portfolioCompanyState createState() => _portfolioCompanyState();
}

class _portfolioCompanyState extends State<portfolioCompany> {
  List<CompanyPortfolio> company = new List<CompanyPortfolio>();
  List<detailCompany> detail = new List<detailCompany>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getStockDetail();
    getCategoryNews();
  }

  getCategoryNews() async {
    StockNews newsClass = StockNews();
    await newsClass.getNew(widget.portfolio);
    company = newsClass.news;
    setState(() {
      //_loading = false;
    });
  }

  getStockDetail() async {
    StockDetail stockDetail = StockDetail();
    await stockDetail.getStockDetail(widget.portfolio);
    detail = stockDetail.stocks;
    setState(() {
      _loading = false;
    });
  }

  Future<void> getNew(String company) async {
    String url =
        "https://newsapi.org/v2/everything?q=$company&from=2021-01-07&to=2021-01-07&sortBy=popularity&apiKey=f3f4556cae7845b78feaef4c8bc9ce1e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    List<CompanyPortfolio> news = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004052),
      appBar: AppBar(
        title: Text(
          widget.portfolio.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: Color(0xff002029),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.nameCompany,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    detail[0].price,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 75,
                    height: 25,
                    child: Text(detail[0].change.toString(),
                        style: TextStyle(color: Colors.white)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: detail[0].change[0] == "-"
                            ? Colors.red
                            : Colors.green),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(
                      "Exchange:   " + detail[0].exchange,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      "Currency:   " + detail[0].currency,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CompanyDetail(
                    exchange: detail[0].exchange,
                    currency: detail[0].currency,
                    open: detail[0].open,
                    high: detail[0].high,
                    low: detail[0].low,
                    close: detail[0].close,
                    volume: detail[0].volume,
                    previousClose: detail[0].previousClose,
                    percentChange: detail[0].percentChange,
                    averageVolumn: detail[0].averageVolume,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "News",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey[400],
                          );
                        },
                        itemCount: company.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogCompanyTile(
                            // imageUrl: company[index].imageUrl,
                            title: company[index].headline,
                            desc: company[index].category,
                            url: company[index].url,
                          );
                        }),
                  ),
                  // Container(
                  //     child: FutureBuilder(
                  //   future: getNew(widget.portfolio),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //     return ListView.separated(
                  //         separatorBuilder: (context, index) {
                  //           return Divider(
                  //             color: Colors.grey[400],
                  //           );
                  //         },
                  //         itemCount: snapshot.data.length,
                  //         shrinkWrap: true,
                  //         physics: ClampingScrollPhysics(),
                  //         itemBuilder: (context, index) {
                  //           return BlogCompanyTile(
                  //             // imageUrl: company[index].imageUrl,
                  //             title: snapshot.data[index].headline,
                  //             desc: snapshot.data[index].category,
                  //             url: snapshot.data[index].url,
                  //           );
                  //         });
                  //   },
                  // )),
                ],
              ),
            ),
    );
  }
}

class BlogCompanyTile extends StatelessWidget {
  final String title, desc, url;
  BlogCompanyTile({
    //@required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.white60),
            )
          ],
        ),
      ),
    );
  }
}

class CompanyDetail extends StatelessWidget {
  final String exchange,
      currency,
      open,
      high,
      low,
      close,
      volume,
      previousClose,
      percentChange,
      averageVolumn;
  CompanyDetail({
    @required this.exchange,
    @required this.currency,
    @required this.open,
    @required this.high,
    @required this.low,
    @required this.close,
    @required this.volume,
    @required this.previousClose,
    @required this.percentChange,
    @required this.averageVolumn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              children: [
                Text("Open:    " + open,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("High:     " + high,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Low:      " + low,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Close:   " + close,
                    style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              children: [
                Text("Volume:                   " + volume,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Previous Close:      " + previousClose,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Percent Change:    " + percentChange,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Average Volume:    " + averageVolumn,
                    style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
        ]);
  }
}
