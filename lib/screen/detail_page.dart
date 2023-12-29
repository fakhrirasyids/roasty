import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roasty2/data/api/api_service.dart';
import 'package:roasty2/provider/detail_provider.dart';
import 'package:roasty2/utils/result_state.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  final String restaurantId;

  const DetailScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (context) =>
          DetailProvider(apiService: ApiService(), idRestaurant: restaurantId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Detail'),
        ),
        body: SingleChildScrollView(
          child: Consumer<DetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Hero(
                        tag: state.result.detailRestaurant.pictureId,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/${state
                              .result.detailRestaurant.pictureId}",
                          errorBuilder: (ctx, error, _) =>
                          const Center(child: Icon(Icons.error)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.result.detailRestaurant.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(state.result.detailRestaurant.city)
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text("Rating: ${state.result.detailRestaurant
                                      .rating}")
                                ],
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          const Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            state.result.detailRestaurant.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Divider(color: Colors.grey),
                          const Text(
                            "Foods & Drinks Menu",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: state.result.detailRestaurant
                                        .menus.foods.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: ListTile(
                                            title: Text(
                                                state.result.detailRestaurant
                                                    .menus.foods[index].name),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: state.result.detailRestaurant
                                        .menus.drinks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: ListTile(
                                            title: Text(
                                                state.result.detailRestaurant
                                                    .menus.drinks[index].name),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Material(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied_outlined,
                            color: Colors.grey,
                            size: 100,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text("Gagal tersambung dengan Internet!"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Material(
                    child: SizedBox(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
