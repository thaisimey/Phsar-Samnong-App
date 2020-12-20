import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/view_model/categories_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/category/category.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  Category category;
  List<Category> catList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesViewModel>(context, listen: false)
          .getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "CATEGORIES",
            ),
            Spacer(),
            Icon(Icons.close)
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12, bottom: 12),
            child: Text("All Categories"),
          ),
          Expanded(
            child: Selector<CategoriesViewModel, List<Category>>(
                selector: (context, viewModel) => viewModel.catList,
                builder: (__, value, ___) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(left:AppDimen.value6,right: AppDimen.value6,bottom: AppDimen.value10),
                            child: Container(
                              color: Colors.white,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(AppDimen.value4),
                                      child: Container(
                                        height: 100,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(
                                              "${Constant.baseURL}/${value[index].icon}"),
                                        )),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          value[index].nameEn,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                                  ],
                                ),
                              ),
                            ));
                      });
                }),
          ),
        ],
      ),
    );
  }
}
