import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phsar_samnong/component/component_pro.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_color.dart';
import '../../constant/app_dimen.dart';
import '../../constant/app_dimen.dart';
import '../../model/category/category.dart';
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
              color: HexColor(AppColor.background),
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
                                          SizedBox(height: AppDimen.value4,),
                                          Padding(
                                            padding: const EdgeInsets.only(left:AppDimen.value10,right: AppDimen.value10,bottom: AppDimen.value8),
                                            child: Row(
                                              children: [
                                                Text(value[position].nameEn,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                                                Spacer(),
                                                Text("More",style: TextStyle(fontWeight: FontWeight.bold,color: HexColor(AppColor.red.toString())),)
                                              ],
                                            ),
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
