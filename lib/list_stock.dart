import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'model_name_stock.dart';

class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  Future<List<Stock>> futureStock;

  Future<List<Stock>> _getstockname() async {
    var datastock =
        await http.get("https://api.twelvedata.com/stocks?source=account");
    log('$datastock');
    return compute(parseStock, datastock.body);
  }

  List<Stock> parseStock(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Stock>((json) => Stock.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    futureStock = _getstockname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff004052),
        body: Container(
          child: FutureBuilder<List<Stock>>(
            future: futureStock,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text(
                      "loading...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data[index].symbol,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
