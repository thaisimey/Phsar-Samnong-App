import 'package:flutter/material.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/repository/api_service.dart';

class RelatedProductView extends StatefulWidget {
  final int id;
  const RelatedProductView(this.id);
  @override
  _RelatedProductViewState createState() => _RelatedProductViewState();
}

class _RelatedProductViewState extends State<RelatedProductView> {

  List<Item> relatedList = List();
  int proID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    proID = widget.id;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      relatedList = await ApiService.getProductRelated(proID);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDimen.value14),
          child: Text(
            "Related product",
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

        // ComponentPro.itemList(relatedList,context),

        Stack(
          children: [
            (relatedList.length <= 0)
                ? Container(
              height:
              MediaQuery.of(context).size.height / 5,
              child: Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/home/icon/nodata.png",
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppDimen.value8),
                      child: Text(
                        "no data",
                        style:
                        TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Container(
              height: 160,
              padding: EdgeInsets.only(left: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedList.length,
                  itemBuilder: (context, position) {
                    var item = relatedList[position];
                    return ComponentPro.movieItem(
                        item, context);
                  }),
            ),
            (relatedList.length <= 0)
                ? SizedBox.shrink()
                : Positioned(
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
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }


}
