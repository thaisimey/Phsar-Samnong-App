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
                        Selector<SearchViewModel, List<Item>>(
                          selector: (context, value) => value.searchList,
                          builder: (__, value, ___) {
                            return ListView.builder(
                                // controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: value.length,
                                itemBuilder: (BuildContext context,
                                    int position) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DetailView(value[position])),
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
                                                            "${Constant.baseURL}/${value[position].itemImg}"),
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
                                                        value[position].nameEn,
                                                        style: TextStyle(
                                                            color: Colors.black87,
                                                            fontSize: 12),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${value[position].prices[0].price} / ${value[position].prices[0].uom.nameEn} ",
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
                          },

                        ),
                        Selector<SearchViewModel, ViewState>(
                          selector: (context, value) => value.viewStateSearch,
                          builder: (__, value, ___) {
                            if(value == ViewState.Loading) {
                              return Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: CircularProgressIndicator(backgroundColor: Colors.red,),
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
                              return Center(
                                  child: Text('Your search did not have any results',style: TextStyle(color: Colors.grey,fontSize: 20),)
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


