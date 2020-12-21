import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/view/screen/product_by_category_view.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/category/category.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  Category category;
  List<Category> catList = [];
  StreamSubscription subscription;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      print("result ${result}");
      if (result == ConnectivityResult.none) {
        return Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "no internet",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),

          duration: Duration(seconds: 6),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesViewModel>(context, listen: false)
          .getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "CATEGORIES",
            ),
            Spacer(),
            InkWell(
              onTap: () {},
                child: Icon(Icons.close))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12, bottom: 12),
            child: Text("All Categories"),
          ),
          Expanded(
            child: Selector<CategoriesViewModel, List<Category>>(
                selector: (context, viewModel) => viewModel.catList,
                builder: (__, value, ___) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left:AppDimen.value6,right:AppDimen.value6,top: AppDimen.value4,bottom: AppDimen.value4),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductByCategoriesView(catID: value[index].id,)));
                              },
                              child: Container(
                                color: Colors.transparent,
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 90,

                                        child: CachedNetworkImage(
                                          imageUrl: value[index].icon == null
                                              ? ""
                                              : "${Constant.baseURL}/" +
                                              value[index].icon,
                                          imageBuilder: (context, imageProvider) => Container(
                                            // width: 30.0,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider),
                                            ),
                                          ),

                                          placeholder: (context, url) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey,),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            value[index].nameEn,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
