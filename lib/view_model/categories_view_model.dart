import 'package:flutter/cupertino.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/repository/api_service.dart';

import '../model/category/category.dart';

class CategoriesViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Empty;

  ViewState get viewState => _viewState;
  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  List<Category> _catList = List();
  List<Category> get catList => _catList;

  set catList(List<Category> value) {
    _catList = value;
    notifyListeners();
  }

  void getCategories() async {
    try {
      viewState = ViewState.Loading;
      Future.delayed(Duration(milliseconds: 1000),() {
        viewState = ViewState.Data;
      });
      var cat = await ApiService.getCategories();
      catList = cat;

      if(catList.length <= 0 ) {
        viewState = ViewState.Empty;
      } else {
        viewState = ViewState.Data;
      }
    } catch (e) {
      viewState = ViewState.Error;
      print("error ${e}");
    }
  }
}
