import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roasty2/provider/search_provider.dart';
import 'package:roasty2/data/api/api_service.dart';
import 'package:roasty2/utils/result_state.dart';
import 'package:roasty2/widget/card_restaurant.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /* for responsive */
        child: SingleChildScrollView(
          /* padding screen */
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              /* search input */
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFc80064),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  fillColor: Colors.grey,
                ),
              ),

              /* line space */
              const SizedBox(
                height: 16,
              ),

              /* content */
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                /* if has data input */
                child: _controller.text.isNotEmpty
                    ? ChangeNotifierProvider<SearchProvider>(
                        create: (context) => SearchProvider(
                          apiService: ApiService(),
                          key: _controller.text,
                        ),
                        child: Consumer<SearchProvider>(
                          builder: (context, state, _) {
                            /* load data */
                            if (state.state == ResultState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            /* has data */
                            else if (state.state == ResultState.hasData) {
                              /* found data */
                              if (state.result.founded != 0) {
                                return ListView.builder(
                                  itemCount: state.result.founded,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardRestaurant(
                                        restaurant: state.result.restaurants[index]);
                                  },
                                );
                              }
                              /* not found data */
                              else {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sentiment_neutral_outlined,
                                      color: Colors.grey,
                                      size: 150,
                                    ),
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      child: Text("Data tidak ditemukan!"),
                                    ),
                                  ],
                                );
                              }
                            }
                            /* no data */
                            else if (state.state == ResultState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            }
                            /* error */
                            else if (state.state == ResultState.error) {
                              return const Center(
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
                      )
                    : const SizedBox(
                  child: Center(
                    child: Text("Cari Restaurant disini!"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
