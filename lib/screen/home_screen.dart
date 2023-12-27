import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roasty2/model/restaurant_response.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roasty"),
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final restaurantResponse =
              restaurantResponseFromJson(snapshot.data!);
              final restaurants = restaurantResponse.restaurants;
              print("yayaya ***${restaurants}***");
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                },
              ); 
            } else {
              return Text('data');
            }
          }),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      restaurant.pictureId,
      width: 100,
      errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
    ),
    title: Text(restaurant.name),
    subtitle: Text(restaurant.id),
  );
}
