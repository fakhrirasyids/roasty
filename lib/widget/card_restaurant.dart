import 'package:flutter/material.dart';
import 'package:roasty2/data/model/restaurant_response.dart';
import 'package:roasty2/screen/detail_page.dart';
import 'package:roasty2/theme/styles.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Hero(
            tag: restaurant.pictureId!,
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
              errorBuilder: (ctx, error, _) =>
              const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
        title: Text(
          restaurant.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(restaurant.city!)
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
                Text("Rating: ${restaurant.rating}")
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, DetailScreen.routeName,
              arguments: restaurant.id);
        },
      ),
    );
  }
}

// Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
//   return ListTile(
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     leading: Hero(
//       tag: restaurant.pictureId!,
//       child: Image.network(
//         restaurant.pictureId!,
//         width: 100,
//         errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
//       ),
//     ),
//     title: Text(
//       restaurant.name!,
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     subtitle: Column(
//       children: [
//         Row(
//           children: [
//             const Icon(
//               Icons.location_on,
//               color: Colors.grey,
//               size: 16,
//             ),
//             const SizedBox(width: 4),
//             Text(restaurant.city!)
//           ],
//         ),
//         Row(
//           children: [
//             const Icon(
//               Icons.star,
//               color: Colors.grey,
//               size: 16,
//             ),
//             const SizedBox(width: 4),
//             Text("Rating: ${restaurant.rating}")
//           ],
//         ),
//       ],
//     ),
//     onTap: () {
//       // Navigator.pushNamed(context, DetailScreen.routeName,
//       //     arguments: restaurant);
//     },
//   );
// }
