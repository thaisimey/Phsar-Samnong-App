import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_image.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductItemView extends StatefulWidget {
  final int catID;
  const ProductItemView({Key key, @required this.catID}) : super(key: key);

  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> with AutomaticKeepAliveClientMixin {

  StreamController<List<Item>> stream = StreamController();

  int page = 1;
  List<Item> itemList = List();
  ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    //   itemList = await Provider.of<ProductViewModel>(context, listen: false).getProducts(widget.catID, page);
    //   stream.add(itemList);
    // });
  }

  Future<List<Item>> getItem(BuildContext context) async {
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    itemList = await Provider.of<ProductViewModel>(context, listen: false).getProducts(widget.catID, page);
    print("itemList result ${itemList.length}");

    // });
    return Future.value(itemList);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 140,
        child: Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  FutureBuilder<List<Item>>(
                      future: getItem(context),
                      builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                        if(snapshot.data != null && !snapshot.hasError) {
                          return ListView.builder(
                            controller: _scrollController,
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              addAutomaticKeepAlives: true,
                              itemBuilder: (context, position) {
                                var item = itemList[position];
                                return ComponentPro.movieItem(item, context);
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                                strokeWidth: 2,
                                backgroundColor: Colors.transparent,
                              ));
                        }

                      }),
                  Positioned(
                    bottom: 30,
                    right: 5,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(left: 60),
                        // color: Colors.red,
                        height: 80,
                        width: 60,

                        child: Center(
                          child: InkResponse(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                child: Icon(Icons.arrow_forward_ios_rounded,size: 14,)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        )


    );
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}