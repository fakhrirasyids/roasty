import 'package:flutter/cupertino.dart';
import 'package:roasty2/data/api/api_service.dart';
import 'package:roasty2/data/model/restaurant_response.dart';
import 'package:roasty2/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late RestaurantResponse _restaurantResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResponse get result => _restaurantResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurantLists();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResponse = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
