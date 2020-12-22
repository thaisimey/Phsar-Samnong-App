import 'package:flutter/cupertino.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/repository/api_service.dart';

class SearchViewModel extends ChangeNotifier {

  ViewState _viewStateSearch;

  ViewState get viewStateSearch => _viewStateSearch;

  set viewStateSearch(ViewState value) {
    _viewStateSearch = value;
    notifyListeners();
  }

  List<Item> _searchList = List();


  List<Item> get searchList => _searchList;

  set searchList(List<Item> value) {
    _searchList = value;
    notifyListeners();
  }

  int count() {
    return searchList.length;
  }



  Future<void> getSearch(String keyword,int page,int limit) async {
    try {

      viewStateSearch = ViewState.Loading;
      Future.delayed(Duration(milliseconds: 1000),() {
        viewStateSearch = ViewState.Data;
      });

      var resultSearch = await ApiService.getSearch(keyword,page,limit:limit);

      viewStateSearch = ViewState.Loading;
      searchList = resultSearch;

      if(searchList.length <= 0 ) {
        viewStateSearch = ViewState.Empty;
      } else {
        viewStateSearch = ViewState.Data;
      }

    } catch (e) {
      viewStateSearch = ViewState.Error;
    }

  }
}