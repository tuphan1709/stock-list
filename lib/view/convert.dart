import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_final/models/currency_model.dart';

class convertMoney extends StatefulWidget {
  convertMoney({Key key}) : super(key: key);
  @override
  _convertMoneyState createState() => _convertMoneyState();
}

class _convertMoneyState extends State<convertMoney> {
  Future<Currency> _data;
  String _base = "USD";
  List dataList = List();
  TextEditingController numberCurrency = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = fetchAPI(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    var value;
    return Scaffold(
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                color: Colors.black,
                width: 80,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: numberCurrency,
              //obscureText: true,
              textAlign: TextAlign.center,
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Input Currency",
              ),
            ),
          ),
          Row(
            children: [
              Spacer(flex: 1),
              new DropdownButton<String>(
                focusColor: Color(0xff7c94b6),
                items: dataList.map((item) {
                  return new DropdownMenuItem<String>(
                    value: item.key,
                    child: new Text(item.key),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _base = value.toString();
                    _data = fetchAPI(http.Client());
                  });
                },
                value: _base,
              ),
              Spacer(
                flex: 5,
              ),
              new RaisedButton(
                textColor: Color.fromARGB(255, 255, 255, 255),
                color: const Color(0xff7c94b6),
                child: Text("Convert"),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                onPressed: () {
                  setState(() {
                    _base = _base;
                    _data = fetchAPI(http.Client());
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(),
                Text(
                  "Base $_base",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              // Checking data is available....
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.rates.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RowView(
                            context, snapshot.data.rates[index], index);
                      },
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    );
            },
          ))
        ],
      ),
    );
  }

  Widget RowView(BuildContext context, MapEntry<String, dynamic> rate, index) {
    // IconData icon;
    // String imageAsset;
    String imageURL;
    switch (index) {
      case 0:
        imageURL = 'assets/cad.png';
        break;
      case 1:
        imageURL = 'assets/hkd.png';
        break;
      case 2:
        imageURL = 'assets/isk.png';
        break;
      case 3:
        imageURL = 'assets/php.png';
        break;
      case 4:
        imageURL = 'assets/dkk.png';
        break;
      case 5:
        imageURL = 'assets/huf.png';
        break;
      case 6:
        imageURL = 'assets/czk.png';
        break;
      case 7:
        imageURL = 'assets/gbp.png';
        break;
      case 8:
        imageURL = 'assets/ron.png';
        break;
      case 9:
        imageURL = 'assets/sek.png';
        break;
      case 10:
        imageURL = 'assets/idr.png';
        break;
      case 11:
        imageURL = 'assets/inr.png';
        break;
      case 12:
        imageURL = 'assets/brl.png';
        break;
      case 13:
        imageURL = 'assets/rub.png';
        break;
      case 14:
        imageURL = 'assets/hrk.png';
        break;
      case 15:
        imageURL = 'assets/jpy.png';
        break;
      case 16:
        imageURL = 'assets/thb.png';
        break;
      case 17:
        imageURL = 'assets/chf.png';
        break;
      case 18:
        imageURL = 'assets/eur.png';
        break;
      case 19:
        imageURL = 'assets/myr.png';
        break;
      case 20:
        imageURL = 'assets/bgn.png';
        break;
      case 21:
        imageURL = 'assets/trl.png';
        break;
      case 22:
        imageURL = 'assets/cny.png';
        break;
      case 23:
        imageURL = 'assets/nok.png';
        break;
      case 24:
        imageURL = 'assets/nzd.png';
        break;
      case 25:
        imageURL = 'assets/zar.png';
        break;
      case 26:
        imageURL = 'assets/usd.png';
        break;
      case 27:
        imageURL = 'assets/mxn.png';
        break;
      case 28:
        imageURL = 'assets/sgd.png';
        break;
      case 29:
        imageURL = 'assets/aud.png';
        break;
      case 30:
        imageURL = 'assets/ils.png';
        break;
      case 31:
        imageURL = 'assets/krw.png';
        break;
      case 32:
        imageURL = 'assets/pln.png';
        break;
      default:
        imageURL = 'assets/money.png';
    }
    var x = (rate.value * getValueInput());
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image.asset(
            imageURL,
            height: 30,
            width: 30,
          ),
          //Icon(icon, size: 45, color: Color.fromARGB(255, 0, 32, 41)),
          Spacer(flex: 1),
          Text(
            rate.key,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Spacer(flex: 10),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              x.toString(),
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

  Future<Currency> fetchAPI(http.Client client) async {
    final response =
        await client.get("https://api.exchangeratesapi.io/latest?base=$_base");
    final parsedData = jsonDecode(response.body).cast<String, dynamic>();
    Currency dataTemp = Currency.createJSON(parsedData);
    setState(() {
      if (dataList.isEmpty) {
        dataList = (dataTemp.rates != null) ? dataTemp.rates : List();
      }
    });
    return dataTemp;
  }

  double getValueInput() {
    if (numberCurrency.text.isEmpty) return 1;
    return double.parse(numberCurrency.text);
  }
}
