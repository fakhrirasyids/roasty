import 'package:flutter/material.dart';
import 'package:roasty2/data/api/api_service.dart';
import 'package:roasty2/data/model/detail_response.dart';
import 'package:roasty2/utils/result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailProvider({required this.apiService, required idRestaurant}) {
    _fetchDetail(idRestaurant);
  }

  late DetailResponse _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailResponse get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetail(String idRestaurant) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.fetchDetail('/detail/$idRestaurant');
      if (detail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
