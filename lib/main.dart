import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_color.dart';
import 'package:phsar_samnong/constant/behr_splash.dart';
import 'package:phsar_samnong/view/test_view.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:phsar_samnong/view_model/product_detail_model_view.dart';
import 'package:phsar_samnong/view_model/product_view_model.dart';
import 'package:phsar_samnong/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

import 'view/screen/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: CategoriesViewModel()),
      ChangeNotifierProvider.value(value: ProductViewModel()),
      ChangeNotifierProvider.value(value: ProductDetailViewModel()),
      ChangeNotifierProvider.value(value: SearchViewModel()),
      StreamProvider.value(value: Connectivity().onConnectivityChanged),
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
          fontFamily: 'Raleway',
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          platform:TargetPlatform.iOS,
          splashFactory: CustomSplashFactory(),
          splashColor: Colors.grey.withOpacity(0.5),
      ),
      themeMode: ThemeMode.system,
      home: HomeView(),
    );
  }
}
