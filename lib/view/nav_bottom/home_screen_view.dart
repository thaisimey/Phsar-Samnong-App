import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/view/screen/product_by_category_view.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_dimen.dart';
import '../screen/product_item_view.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
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
          messageText: Row(
            children: [
              Text(
                "no internet",
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Container(
                height: 20,
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Try again",
                      style: TextStyle(color: Colors.green),
                    )),
              )
            ],
          ),
          duration: Duration(seconds: 6),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesViewModel>(context, listen: false).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                return Scaffold(
                  body: Column(
                    children: [
                      ComponentPro.tabBar(context),
                      Expanded(
                        child: Container(
                            color: HexColor(AppColor.background),
                            child: Builder(builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Selector<CategoriesViewModel, ViewState>(
                                      selector: (context, viewModel) => viewModel.viewState,
                                      builder: (__, value, ___) {
                                        if (value == ViewState.Data) {
                                          return Consumer<CategoriesViewModel>(builder:
                                              (BuildContext context, value, Widget child) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                if (value.catList.length <= 0) {
                                                  return Container(child: Center());
                                                } else {
                                                  return ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: value.catList.length,
                                                      itemBuilder: (context, position) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              height: AppDimen.value4,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: AppDimen.value10,
                                                                  right: AppDimen.value10,
                                                                  bottom: AppDimen.value8,
                                                                  top: AppDimen.value8 ),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    value.catList[position]
                                                                        .nameEn,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        color:
                                                                        Colors.black87),
                                                                  ),
                                                                  Spacer(),
                                                                  InkWell(
                                                                      onTap: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (BuildContext
                                                                                context) =>
                                                                                    ProductByCategoriesView(
                                                                                      catID: value
                                                                                          .catList[position]
                                                                                          .id,
                                                                                    )));
                                                                      },
                                                                      child: Text(
                                                                        "More",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: HexColor(
                                                                                AppColor.red
                                                                                    .toString())),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(bottom: AppDimen.value20),
                                                              child: ProductItemView(
                                                                catID: value
                                                                    .catList[position].id,
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      });
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
                                      if (value == ViewState.Loading) {
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
                                      if (value == ViewState.Error) {
                                        return Center(
                                          child: Text(
                                            "Error",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                  Selector<CategoriesViewModel, ViewState>(
                                    selector: (context, value) => value.viewState,
                                    builder: (__, value, ___) {
                                      if (value == ViewState.Empty) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/images/home/icon/nodata.png",height: 40,width: 40,),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: AppDimen.value8),
                                                  child: Text("no data",style: TextStyle(color: Colors.grey),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  )
                                ],
                              );
                            })),
                      )
                    ],
                  ),
                );
              }
          );
        }
    );

  }
}