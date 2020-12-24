import 'package:flutter/material.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_image.dart';
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

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    proID = widget.id;
    print("proID $proID");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      // relatedList = await ApiService.getProductRelated(proID);
      // print(relatedList.length);

    });
  }

  Future<List<Item>> getItem(BuildContext context) async {
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    relatedList = await ApiService.getProductRelated(proID);
    print("itemList result ${relatedList.length}");

    // });
    return Future.value(relatedList);
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

        Container(
            height: 140,
            child: Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      FutureBuilder<List<Item>>(
                          future: getItem(context),
                          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                            switch(snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                                      strokeWidth: 2,
                                      backgroundColor: Colors.transparent,
                                    ));
                              default:
                                if (snapshot.hasError)
                                  return Container(
                                    height:
                                    MediaQuery.of(context).size.height / 5,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImage.noData,
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

                                  );
                                else
                                  return ListView.builder(
                                      controller: _scrollController,
                                      itemCount: snapshot.data.length,
                                      scrollDirection: Axis.horizontal,
                                      addAutomaticKeepAlives: true,
                                      itemBuilder: (context, position) {
                                        var item = relatedList[position];
                                        return ComponentPro.movieItem(item, context);
                                      });
                            }

                          }),
                      Positioned(
                        bottom: 60,
                        right: 5,
                        child: Material(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.arrow_forward_ios_rounded,size: 14,color:Colors.black),
                                )),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            )


        )


      ],
    );
  }


}
