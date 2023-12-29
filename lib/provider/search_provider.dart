import 'package:flutter/material.dart';
import 'package:roasty2/data/api/api_service.dart';
import 'package:roasty2/data/model/search_response.dart';
import 'package:roasty2/provider/restaurant_provider.dart';
import 'package:roasty2/utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService, required key}) {
    _fetchAllSearch(key);
  }

  late SearchResponse _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchResponse get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearch(key) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final search = await apiService.fetchSearch('/search?q=$key');
      if (search.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = search;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
