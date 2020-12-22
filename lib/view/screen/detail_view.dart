import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_color.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/detail/detail.dart';
import 'package:phsar_samnong/repository/api_service.dart';
import 'package:phsar_samnong/view/screen/related_product_view.dart';
import 'package:phsar_samnong/view/screen/search_view.dart';

import '../../constant/app_dimen.dart';
import '../../model/product/item.dart';
import '../../repository/api_service.dart';

class DetailView extends StatefulWidget {
  final int id;

  const DetailView(this.id);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int productID;

  // List<Detail> detailList = List();
  List<Mobile> mobileList = List();

  // List<Item> relatedList = List();
  List<Price> priceList = List();

  String title;
  String description = '';
  String specification = '';
  String img = '';
  List<String> gallery = [];
  double price = 0.0;
  String uom = "";
  int view = 0;
  String variation = "";
  int id;

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
    id = widget.id;
    productID = widget.id;
    // print("item ${item.id}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detail = await ApiService.getProductDetail(widget.id);
      print("res detailResponse ${detail.itemImg}");

      // relatedList = await ApiService.getProductRelated(detail.id);

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
        id = detail.id;
        for (var price in detail.prices) {
          priceList.add(price);
        }

        print("list pricelist ${priceList.length}");
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
              InkWell(
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
        body: (title == null)
            ? Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
              ))
            : SingleChildScrollView(
                child: Container(
                  color: HexColor(AppColor.background),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: AppDimen.value14,
                                right: AppDimen.value18,
                                top: AppDimen.value18,
                                bottom: AppDimen.value18),
                            child: Container(
                              height: MediaQuery.of(context).size.height/5,
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(AppDimen.value4))
                              ),
                              child: Container(
                                height: 90,
                                child: CachedNetworkImage(
                                  imageUrl: img == null
                                      ? ""
                                      : "${Constant.baseURL}/" +
                                      img,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 70.0,
                                    height: 90,
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
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: AppDimen.value18),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value6),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value6),
                                    child: Text((description == null)
                                        ? "N/A"
                                        : description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value8),
                                    child: Text("Specification",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value8),
                                    child: Text((specification == null)
                                        ? "N/A"
                                        : specification),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value12),
                                    child: Text(
                                      "\$ ${price.toString()} / $uom",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.value18),
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
                                                "assets/images/social/facebook.png"),
                                            height: 20,
                                            width: 20,
                                          ),
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
                      (gallery.isEmpty)
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppDimen.value14),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: Scrollbar(
                                    thickness: 2,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: gallery.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding: const EdgeInsets.all(18),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${Constant.baseURL}/${gallery[position]}"),
                                                  ),
                                                )),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppDimen.value14, top: AppDimen.value4),
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
                            left: AppDimen.value8, right: AppDimen.value8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.red),
                                    border: Border(
                                        left: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        bottom:
                                            BorderSide(color: Colors.black))),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Variation")),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.red),
                                    border: Border.all(color: Colors.black)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Price")),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: HexColor(AppColor.red),
                                    border: Border(
                                        top: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                        bottom:
                                            BorderSide(color: Colors.black))),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Quantity")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppDimen.value8, right: AppDimen.value8),
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: priceList.length,
                              itemBuilder: (context, position) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        decoration: BoxDecoration(
                                            color: HexColor(AppColor.white),
                                            border: Border(
                                                left: BorderSide(
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    color: Colors.black))),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              priceList[position].variation,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        decoration: BoxDecoration(
                                            color: HexColor(AppColor.white),
                                            border: Border(
                                                left: BorderSide(
                                                    color: Colors.black),
                                                right: BorderSide(
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    color: Colors.black))),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text("${priceList[position]
                                                .price
                                                .toString()}/${priceList[position]
                                                .uom.nameEn}")),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        decoration: BoxDecoration(
                                            color: HexColor(AppColor.white),
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    color: Colors.black))),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  await _showMyDialog();
                                                },
                                                child: Text("0")),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppDimen.value14, top: AppDimen.value12),
                        child: Text(
                          "Contact Information",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: AppDimen.value16,
                                    bottom: AppDimen.value8),
                                child: Row(
                                  children: [
                                    Text(mobileList[index].company.name),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    ),
                                    Text(": ${mobileList[index].phone}"),
                                  ],
                                ),
                              );
                            }),
                      ),
                      RelatedProductView(id)
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
                Align(
                    alignment: Alignment.center,
                    child: Text('Input quantity product')),
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
