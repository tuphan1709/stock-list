import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_final/helper/list_stock.dart';
import 'package:stock_final/models/country_model.dart';

import 'package:stock_final/models/model_name_stock.dart';
import 'package:http/http.dart' as http;
import 'package:stock_final/view/portfolio.dart';

class homeStock extends StatefulWidget {
  final String country;
  homeStock({this.country});
  @override
  _homeStockState createState() => _homeStockState();
}

class _homeStockState extends State<homeStock> {
  List<Stock> stocks = [];
  List<Stock> stockHome = new List<Stock>();
  bool _loading = true;
  String countryselect;

  @override
  void initState() {
    getStockName();
    super.initState();
  }

  getStockName() async {
    StockNameHome newclass = StockNameHome();
    await newclass.getStockName(countryselect);
    stockHome = newclass.stocks;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getStockName();
    return Container(
        child: Scaffold(
            backgroundColor: Color(0xff004052),
            body: _loading
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                        height: 1000,
                        child: Column(
                          children: <Widget>[
                            CountryCodePicker(
                                showOnlyCountryWhenClosed: true,
                                showCountryOnly: true,
                                showDropDownButton: true,
                                textStyle: TextStyle(color: Colors.white),
                                backgroundColor: Color(0xff004052),
                                //dialogBackgroundColor: Color(0xff004A5F),
                                dialogTextStyle: TextStyle(color: Colors.black),
                                alignLeft: true,
                                initialSelection: 'IT',
                                favorite: ['+1', 'US'],
                                padding: EdgeInsets.all(16),
                                onChanged: (CountryCode code) {
                                  this.setState(() {
                                    countryselect = code.name;
                                  });
                                }),
                            Expanded(
                              child: Scrollbar(
                                thickness: 3,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.grey[400],
                                      );
                                    },
                                    padding: EdgeInsets.all(16),
                                    itemCount: stockHome.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return StockHomePage(
                                        symbol: stockHome[index].symbol,
                                        name: stockHome[index].name,
                                        //price: stockHome[index].price,
                                      );
                                    }),
                              ),
                            ),
                          ],
                        )),
                  )));
  }
}

class StockHomePage extends StatelessWidget {
  final String symbol, name;
  StockHomePage({
    @required this.symbol,
    @required this.name,
    // @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => portfolioCompany(
                      portfolio: symbol.toString(),
                      nameCompany: name.toString(),
                    )));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              symbol,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
            // Text(
            //   price,
            //   style: TextStyle(
            //       color: Colors.grey[200],
            //       fontSize: 16,
            //       fontWeight: FontWeight.w300),
            // ),
          ],
        ),
      ),
    );
  }
}
