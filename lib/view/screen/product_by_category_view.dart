import 'package:flutter/material.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/view/screen/search_view.dart';
import 'package:phsar_samnong/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductByCategoriesView extends StatefulWidget {
  final int catID;
  const ProductByCategoriesView({Key key, this.catID}) : super(key: key);
  @override
  _ProductByCategoriesState createState() => _ProductByCategoriesState();
}

class _ProductByCategoriesState extends State<ProductByCategoriesView> {


  int page = 1;
  List<Item> itemList = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Cat ID ${widget.catID}");
  }

  Future<List<Item>> getItem(BuildContext context) async {
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    itemList = await Provider.of<ProductViewModel>(context, listen: false).getProducts(widget.catID, page);
    print("itemListall result ${itemList.length}");

    // });
    return Future.value(itemList);
  }
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
      body: Container(
        padding: EdgeInsets.all(AppDimen.value6),
          child: Builder(
              builder: (BuildContext context) {
                return FutureBuilder<List<Item>>(
                    future: getItem(context),
                    builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                      if(snapshot.data != null && !snapshot.hasError) {
                        return GridView.builder(
                          // controller: _scrollController,
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            addAutomaticKeepAlives: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6,
                                crossAxisCount: 4,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 10.0),
                            itemBuilder: (context, position) {
                              var item = itemList[position];
                              return ComponentPro.movieGridItem(item, context);
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }

                    });
              }
          )


      )

    );
  }
}
