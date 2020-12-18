import 'package:flutter/cupertino.dart';
import 'file:///D:/Flutter/phsar_samnong/lib/model/category/category.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/repository/api_service.dart';

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
      var cat = await ApiService.getCategories();
      catList = cat;
    } catch (e) {
      print("error ${e}");
    }
  }
}
