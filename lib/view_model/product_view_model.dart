import 'package:flutter/cupertino.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/repository/api_service.dart';

class ProductViewModel extends ChangeNotifier {

  ViewState _viewState = ViewState.Empty;

  ViewState get viewState => _viewState;

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  List<Item> _listPro = [];

  List<Item> get listPro => _listPro;

  set listPro(List<Item> value) {
    _listPro = value;
    notifyListeners();
  }

  Future<List<Item>> getProducts(int categoryID,int page) async {
    try {
      viewState = ViewState.Loading;
      var pro = await ApiService.getProduct(categoryID, page);
      // print("pro $pro");
      return pro;

    } catch (e) {
      print("error ${e}");
      return List();
    }
  }

}