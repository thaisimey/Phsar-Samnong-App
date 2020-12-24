import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_image.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/view/screen/product_by_category_view.dart';
import 'package:phsar_samnong/view/screen/product_item_view.dart';
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
      body: Container(
          child : Stack(
            children: [
              Selector<CategoriesViewModel, ViewState>(
                  selector: (context, viewModel) => viewModel.viewState,
                  builder: (__, value, ___) {
                    if(value == ViewState.Data) {
                      return  Consumer<CategoriesViewModel>(builder: (BuildContext context, value, Widget child) {
                        return Builder(
                          builder: (BuildContext context){
                            if (value.catList.length <= 0) {
                              return Container(
                                  child: Center());
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: AppDimen.value18,top: 10,bottom: 10),
                                    child: Text("All Categories"),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: value.catList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left:AppDimen.value6,right:AppDimen.value6,top: AppDimen.value4,bottom: AppDimen.value4),
                                            child: Material(
                                              color: Colors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductByCategoriesView(catID: value.catList[index].id,)));
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
                                                            imageUrl: value.catList[index].icon == null
                                                                ? ""
                                                                : "${Constant.baseURL}/" +
                                                                value.catList[index].icon,
                                                            imageBuilder: (context, imageProvider) => Container(
                                                              // width: 30.0,
                                                              height: 10,
                                                              decoration: BoxDecoration(
                                                                // shape: BoxShape.circle,
                                                                image: DecorationImage(
                                                                    image: imageProvider),
                                                              ),
                                                            ),

                                                            placeholder: (context, url) => Image.asset(AppImage.logoMedium,color: Colors.grey),
                                                            errorWidget: (context, url, error) => Image.asset(AppImage.logoMedium,color: Colors.grey,),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              value.catList[index].nameEn,
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
                                        }),
                                  ),
                                ],
                              );
                            }

                          },
                        );
                      });
                    } else {
                      return SizedBox.shrink();
                    }
                  }),

              Selector<CategoriesViewModel, ViewState>(
                selector: (context, value) => value.viewState,
                builder: (__, value, ___) {
                  if(value == ViewState.Loading) {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 2,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),

              Selector<CategoriesViewModel, ViewState>(
                selector: (context, value) => value.viewState,
                builder: (__, value, ___) {
                  if(value == ViewState.Error) {
                    return Center(
                      child: Text("Error",style: TextStyle(color: Colors.white,fontSize: 20),),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),

              Selector<CategoriesViewModel, ViewState>(
                selector: (context, value) => value.viewState,
                builder: (__, value, ___) {
                  if(value == ViewState.Empty) {
                    return Center(
                        child: Text('Empty data')
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            ],
          )

      ),
    );
  }
}
