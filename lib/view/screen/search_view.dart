import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phsar_samnong/constant/app_color.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/view/screen/detail_view.dart';
import 'package:phsar_samnong/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}


class _SearchViewState extends State<SearchView> {

  StreamSubscription subscription;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      print("result ${result}");
      if (result == ConnectivityResult.none) {
        return Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "no internet",
          icon:
          Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          messageText: Row(
            children: [
              Text("no internet",style: TextStyle(color: Colors.white),),
              Spacer(),
              Container(
                height: 20,
                child: FlatButton(onPressed: (){},
                    child: Text("Try again",style: TextStyle(color: Colors.green),)),
              )

            ],
          ),

          duration: Duration(seconds: 6),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomSearchBar(),
      body : Column(
        children: [
          Selector<SearchViewModel, int>(
            selector: (context,viewModel) => viewModel.count(),
            builder: (__, value, ___) {
              return Padding(
                padding: const EdgeInsets.only(left: AppDimen.value34),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: (value == 0) ? SizedBox.shrink()
                    :Text("${value.toString()} Items",style: TextStyle(color: HexColor(AppColor.proNameColor)),)),
              );

            },

          ),

          SizedBox(
            height: 10,
          ),

          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Selector<SearchViewModel, ViewState>(
                          selector: (context, value) => value.viewStateSearch,
                          builder: (__, value, ___) {
                            if (value == ViewState.Data) {
                              return Consumer<SearchViewModel>(builder:
                                  (BuildContext context, value, Widget child) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    if (value.searchList.length <= 0) {
                                      return Container(child: Center());
                                    } else {
                                      return ListView.builder(
                                        // controller: _scrollController,
                                          scrollDirection: Axis.vertical,
                                          itemCount: value.searchList.length,
                                          itemBuilder: (BuildContext context,
                                              int position) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => DetailView(value.searchList[position].id)),
                                                );
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 45,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 18.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 90,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      "${Constant.baseURL}/${value.searchList[position].itemImg}"),
                                                                )),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context).size.width / 1.5,
                                                                child: Text(
                                                                  value.searchList[position].nameEn,
                                                                  style: TextStyle(
                                                                      color: Colors.black87,
                                                                      fontSize: 12),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${value.searchList[position].prices[0].price} / ${value.searchList[position].prices[0].uom.nameEn} ",
                                                                style: TextStyle(
                                                                    color: Colors.black87,
                                                                    fontSize: 12),
                                                              ),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            );


                                          }
                                      );
                                    }
                                  },
                                );
                              });
                            } else {
                              return SizedBox.shrink();
                            }
                          },

                        ),
                        Selector<SearchViewModel, ViewState>(
                          selector: (context, value) => value.viewStateSearch,
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

                        Selector<SearchViewModel, ViewState>(
                          selector: (context, value) => value.viewStateSearch,
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

                        Selector<SearchViewModel, ViewState>(
                          selector: (context, value) => value.viewStateSearch,
                          builder: (__, value, ___) {
                            if(value == ViewState.Empty) {
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
                  }

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget with PreferredSizeWidget {
  String keyword = "";
  int page = 1;
  int limit;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 30,
          right: 0,
          left: 2,
          child: Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                IconButton(
                  splashColor: Colors.grey,
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child:TextField(
                    onSubmitted: (value) {
                      // searchMovie(isLoadMore: false, word: value);
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<SearchViewModel>(context,listen: false).getSearch(value, page, limit);
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black12),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () => _controller.clear(),
                          icon: Icon(Icons.clear,color: Colors.grey,),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 15, left: 10, right: 0.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


