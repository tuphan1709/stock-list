import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_final/home_stock.dart';
import 'package:stock_final/news.dart';

import 'convert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> containers = [
    Container(
      color: Color(0xff004052),
    ),
    Container(
      color: Color(0xff004052),
    ),
    Container(
      color: Color(0xff004052),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stock",
              style: TextStyle(
                  color: Color(0xff00C9FF),
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xff002029),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 4.0,
            labelStyle: TextStyle(fontSize: 20),
            tabs: <Widget>[
              Tab(
                text: "Stock",
              ),
              Tab(
                text: "Currency",
              ),
              Tab(
                text: "News",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            homeStock(),
            convertMoney(),
            news()
          ],
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double categoriesHeight = MediaQuery.of(context).size.height.abs();
    return Container();
  }
}
