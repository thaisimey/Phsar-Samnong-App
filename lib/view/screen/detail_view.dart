import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phsar_samnong/constant/app_color.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/detail/detail.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/repository/api_service.dart';
import 'package:phsar_samnong/view/screen/search_view.dart';

class DetailView extends StatefulWidget {
  final Item item;

  const DetailView(this.item);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int productID;
  Item item;
  List<Detail> detailList = List();

  // Detail detail;
  String title = '';
  String description = '';
  String specification = '';
  String img = '';
  List<String> gallery = [];
  double price = 0.0;
  String uom = "";
  int view = 0;

  var page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
    productID = item.id;
    // print("item ${item.id}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detail = await ApiService.getProductDetail(item.id);
      print("res detailResponse ${detail.itemImg}");
      setState(() {
        title = detail.nameEn;
        description = detail.descriptionEn;
        specification = detail.specificationEn;
        img = detail.itemImg;
        gallery = detail.gallery;
        price = detail.prices[0].price;
        uom = detail.prices[0].uom.nameEn;
        view = detail.viewCnt;
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
                height: 100,
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppDimen.value2),
                child: Image.asset(
                  "assets/images/home/flag/chinese@3x.png",
                  height: 100,
                  width: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppDimen.value2),
                child: Image.asset(
                  "assets/images/home/flag/united-kingdom@3x.png",
                  height: 100,
                  width: 40,
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
        body: Container(
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
                                          "assets/images/social/facebook.png")),
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
                        return Padding(
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
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppDimen.value14),
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
                                  child: Text("1")),
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
                                  child: Text("22")),
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
                              child: Text("item 4"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text("Contact Information"),
              Container(
                padding: EdgeInsets.only(
                    top: AppDimen.value14,
                    left: AppDimen.value16,
                    right: AppDimen.value16),
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }
}
