import 'package:flutter/cupertino.dart';
import 'package:phsar_samnong/model/detail/detail.dart';
import 'package:phsar_samnong/model/view_state.dart';
import 'package:phsar_samnong/repository/api_service.dart';

class ProductDetailViewModel extends ChangeNotifier {

  ViewState _viewState = ViewState.Empty;

  ViewState get viewState => _viewState;

  List<Detail> _listDetail = List();

  List<Detail> get listDetail => _listDetail;

  set listDetail(List<Detail> value) {
    _listDetail = value;
    notifyListeners();
  }

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  Future<Detail> getDetail(int productID) async {
    try {

      var res = await ApiService.getProductDetail(productID);
      return res;

    } catch (e) {
    }

  }
}