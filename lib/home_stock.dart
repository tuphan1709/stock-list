import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_final/list_stock.dart';

class homeStock extends StatefulWidget {
  @override
  _homeStockState createState() => _homeStockState();
}

class _homeStockState extends State<homeStock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xff004052),
        body: Stack(children: <Widget>[

          Container(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        prefix: Icon(Icons.search, color: Colors.grey[500],),
                        fillColor: Colors.blueGrey,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        )
                      ),
                    ),
                  ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-310,
                    child: StockList(),
                  )
                ],
              ),
            ),

          ),
          // SizedBox(
          //
          //   child: StockList(),
          //)
        ],),
      )
    );
  }
}
