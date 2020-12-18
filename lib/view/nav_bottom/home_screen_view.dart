import 'package:flutter/material.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'file:///D:/Flutter/phsar_samnong/lib/model/category/category.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:provider/provider.dart';

import '../product_item_view.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesViewModel>(context,listen: false).getCategories();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ComponentPro.tabBar(context),
          Expanded(
            child: Container(
                child: Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Selector<CategoriesViewModel, List<Category>>(
                              selector: (context, viewModel) => viewModel.catList,
                              builder: (__,value,___) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: value.length,
                                    itemBuilder: (context,position) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(value[position].nameEn,style: TextStyle(color: Colors.black87),),
                                              Spacer(),
                                              Text("More")
                                            ],
                                          ),
                                          ProductItemView(catID: value[position].id,)
                                        ],
                                      );
                                    });
                              }
                          )
                        ],
                      );
                    }
                )
            ),
          )





        ],
      ),
    );
  }
}
