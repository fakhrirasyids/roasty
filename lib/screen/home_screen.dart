import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roasty2/provider/restaurant_provider.dart';
import 'package:roasty2/utils/result_state.dart';
import 'package:roasty2/widget/card_restaurant.dart';
import 'package:roasty2/widget/platform_widget.dart';
import 'package:roasty2/screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(""),
            ),
          );
        }
      },
    );
  }


  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roasty'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: const Color(0xFFc80064),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Roasty'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
