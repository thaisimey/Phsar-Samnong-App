import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_color.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/detail/detail.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/repository/api_service.dart';
import 'package:phsar_samnong/view/screen/search_view.dart';

import '../../constant/app_dimen.dart';
import '../../model/product/item.dart';
import '../../repository/api_service.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailView extends StatefulWidget {
  final Item item;

  const DetailView(this.item);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int productID;
  Item item;
  // List<Detail> detailList = List();
  List<Mobile> mobileList = List();
  List<Item> relatedList = List();

  // Detail detail;
  String title;
  String description = '';
  String specification = '';
  String img = '';
  List<String> gallery = [];
  double price = 0.0;
  String uom = "";
  int view = 0;
  String variation = "";


  var page;
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

          duration: Duration(seconds: 30),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    });
    super.initState();
    item = widget.item;
    productID = item.id;
    // print("item ${item.id}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detail = await ApiService.getProductDetail(item.id);
      print("res detailResponse ${detail.itemImg}");

      relatedList = await ApiService.getProductRelated(detail.id);

      setState(() {
        title = detail.nameEn;
        description = detail.descriptionEn;
        specification = detail.specificationEn;
        img = detail.itemImg;
        gallery = detail.gallery;
        price = detail.prices[0].price;
        uom = detail.prices[0].uom.nameEn;
        view = detail.viewCnt;
        variation = detail.prices[0].variation;
        mobileList = detail.mobile;
      });
    });
  }

  // Future<List<Detail>> getDetail(BuildContext context) async {
  //   // WidgetsBinding.instance.addPostFrameCallback((_) async{
  //   detailList.add(await Provider.of<ProductDetailViewModel>(context, listen: false).getDetail(productID));
  //   print("itemList result ${detailList.length}");
  //   // });
  //   return Future.value(detailList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/logo/logo@3x.png",
                width: 80,
              ),
              SizedBox(
                width: 15,
              ),
              Image.asset(
                "assets/images/home/flag/khmer@3x.png",

                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppDimen.value2),
                child: Image.asset(
                  "assets/images/home/flag/chinese@3x.png",
                  width: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppDimen.value2),
                child: Image.asset(
                  "assets/images/home/flag/united-kingdom@3x.png",
                  width: 25,
                ),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SearchView()));
                  },
                  child: Image.asset("assets/images/home/icon/search.png"))
            ],
          ),
        ),
        body: (title == null) ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Container(
            color: HexColor(AppColor.background),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width/2.5,
                    //   height: MediaQuery.of(context).size.height/4,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: NetworkImage(
                    //             "${Constant.baseURL}/$img"),
                    //       )),
                    //   ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppDimen.value14,
                          right: AppDimen.value18,
                          top: AppDimen.value18,
                          bottom: AppDimen.value18),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 5.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage("${Constant.baseURL}/$img"),
                            ),
                          )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: AppDimen.value18),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value6),
                              child: Text(
                                "Description",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value6),
                              child: Text(
                                  (description == null) ? "N/A" : description),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value8),
                              child: Text("Specification",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value8),
                              child: Text((specification == null)
                                  ? "N/A"
                                  : specification),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value12),
                              child: Text(
                                "\$ ${price.toString()} / $uom",
                                style:
                                    TextStyle(color: Colors.green, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimen.value18),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppDimen.value4,
                                        right: AppDimen.value4),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppDimen.value4,
                                        right: AppDimen.value4),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/social/facebook.png"),height: 20,width: 20,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppDimen.value4,
                                        right: AppDimen.value4),
                                    child: Icon(Icons.share),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppDimen.value4,
                                        right: AppDimen.value4),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/social/eyes.png"),
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  Text(
                                    view.toString(),
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppDimen.value6,
                ),

                (gallery.isEmpty) ? SizedBox.shrink()
                    : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppDimen.value14),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gallery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        // top: AppDimen.value14,
                          left: AppDimen.value16,
                          right: AppDimen.value16),
                      width: MediaQuery.of(context).size.width,
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Scrollbar(
                        thickness: 2,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gallery.length,
                            itemBuilder: (context, position) {
                              return GestureDetector(
                                onTap: () {
                                  PhotoViewGallery.builder(
                                    itemCount: gallery.length,
                                    builder: (context, index) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider: NetworkImage(
                                          gallery[index],
                                        ),
                                        // Contained = the smallest possible size to fit one dimension of the screen
                                        minScale: PhotoViewComputedScale.contained * 0.8,
                                        // Covered = the smallest possible size to fit the whole screen
                                        maxScale: PhotoViewComputedScale.covered * 2,
                                      );
                                    },
                                    scrollPhysics: BouncingScrollPhysics(),
                                    // Set the background color to the "classic white"
                                    backgroundDecoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    loadFailedChild: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.height / 3,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${Constant.baseURL}/${gallery[position]}"),
                                        ),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: AppDimen.value14,top: AppDimen.value4),
                  child: Text(
                    "Price Lists",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: AppDimen.value16, right: AppDimen.value16),
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppDimen.value12, right: AppDimen.value12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.grey),
                                    border: Border(
                                      left:BorderSide(color:Colors.black),
                                      top: BorderSide(color:Colors.black),
                                      bottom: BorderSide(color:Colors.black)
                                    )),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Variation")),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.background),
                                    border: Border(
                                        left:BorderSide(color:Colors.black),
                                        bottom: BorderSide(color:Colors.black)
                                    )),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(variation)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.grey),
                                    border: Border.all(color: Colors.black)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Price")),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.background),
                                    border: Border(
                                        right:BorderSide(color:Colors.black),
                                        left:BorderSide(color:Colors.black),
                                        bottom: BorderSide(color:Colors.black)
                                    )),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("\$ ${price.toString()} / $uom")),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.grey),
                                    border: Border(
                                        top:BorderSide(color:Colors.black),
                                        right:BorderSide(color:Colors.black),
                                        bottom: BorderSide(color:Colors.black)
                                    )),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Quantity")),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.background),
                                    border: Border(
                                        right:BorderSide(color:Colors.black),
                                        bottom: BorderSide(color:Colors.black)
                                    )),
                                child: Container(
                                  child: Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.remove),),
                                      GestureDetector(
                                        onTap: () async {
                                          await _showMyDialog();
                                        },
                                          child: Text("1")),
                                      IconButton(icon: Icon(Icons.add),),
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppDimen.value14,top: AppDimen.value12),
                  child: Text("Contact Information",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.only(
                      // top: AppDimen.value14,
                      left: AppDimen.value16,
                      right: AppDimen.value16),
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),

                Container(
                  height: 60,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mobileList.length,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.only(left:AppDimen.value16,bottom: AppDimen.value8),
                          child: Row(
                            children: [
                              Text(mobileList[index].company.name),
                              SizedBox(width: MediaQuery.of(context).size.width / 3,),
                              Text(": ${mobileList[index].phone}"),

                            ],
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppDimen.value14),
                  child: Text("Related product",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.only(
                    // top: AppDimen.value14,
                      left: AppDimen.value16,
                      right: AppDimen.value16),
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),

                // ComponentPro.itemList(relatedList,context),

                Stack(
                  children: [
                    Container(
                      height: 160,
                      padding: EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedList.length,
                          itemBuilder: (context,position) {
                            var item = relatedList[position];
                            return ComponentPro.movieItem(item, context);

                      }),
                    ),
                    Positioned(
                      bottom: 80,
                      right: 5,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded,size: 14,color:Colors.black,),onPressed: () {

                            },),
                          )),
                    ),
                  ],
                )



              ],
            ),
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Align(alignment: Alignment.center,child: Text('Input quantity product')),
                Padding(
                  padding: const EdgeInsets.only(top: AppDimen.value10),
                  child: Container(
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
