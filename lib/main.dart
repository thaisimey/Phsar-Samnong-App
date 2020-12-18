import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Flutter/phsar_samnong/lib/view/screen/categories_view.dart';
import 'package:phsar_samnong/view/home_view.dart';
import 'package:phsar_samnong/view/screen/detail_view.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:phsar_samnong/view_model/product_detail_model_view.dart';
import 'package:phsar_samnong/view_model/product_view_model.dart';
import 'package:phsar_samnong/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: CategoriesViewModel()),
      ChangeNotifierProvider.value(value: ProductViewModel()),
      ChangeNotifierProvider.value(value: ProductDetailViewModel()),
      ChangeNotifierProvider.value(value: SearchViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      themeMode: ThemeMode.system,
      home: HomeView(),
    );
  }
}
