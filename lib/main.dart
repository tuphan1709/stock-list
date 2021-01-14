import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:stock_final/home_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
