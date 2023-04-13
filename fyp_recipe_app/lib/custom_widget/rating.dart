import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../network/api_response.dart';
import '../provider/rate_provider.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.recipeId});
  final String recipeId;

  @override
  // ignore: library_private_types_in_public_api
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late double _ratingValue;
  late final RateRecipeProvider ratingProvider;

  void ratingListener() async {
    if (ratingProvider.rateResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ratingProvider.rateResponse.error.toString())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Rating has been sent.")));
    }
  }

  @override
  void initState() {
    ratingProvider = context.read<RateRecipeProvider>();
    ratingProvider.addListener(ratingListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Rate the recipe:',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        RatingBar(
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.orange),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.orange,
                ),
                empty: const Icon(
                  Icons.star_outline,
                  color: Colors.orange,
                )),
            onRatingUpdate: (value) {
              setState(() {
                _ratingValue = value;
              });
            }),
        const SizedBox(height: 16.0),
        ElevatedButton(
            child: const Text('Submit Rating'),
            onPressed: () {
              context.read<RateRecipeProvider>().rate(
                    rating: _ratingValue,
                    recipeID: widget.recipeId,
                  );
            }),
      ],
    );
  }
}
