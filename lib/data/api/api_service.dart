import 'dart:convert';

import 'package:roasty2/data/model/detail_response.dart';
import 'package:roasty2/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:roasty2/data/model/search_response.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResponse> getRestaurantLists() async {
    final restaurantResponse = await http.get(Uri.parse("${_baseUrl}list"));
    if (restaurantResponse.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(restaurantResponse.body));
    } else {
      throw Exception('Failed to load Restaurant Lists!');
    }
  }

  Future<DetailResponse> fetchDetail(String path) async {
    final response = await http.get(Uri.parse(_baseUrl + path));
    if (response.statusCode == 200) {
      return DetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<SearchResponse> fetchSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + query));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Searching Data');
    }
  }
}
