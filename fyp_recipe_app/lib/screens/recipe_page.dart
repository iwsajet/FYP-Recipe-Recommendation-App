import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fyp_recipe_app/custom_widget/kebab_menu.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  double? _ratingValue;
   bool isBookmarked = false;
     Future<void> handleReportSubmitted(String reportMessage) async {
  // perform the report submission operation here
  await Future.delayed(Duration(seconds: 2)); // simulate a network request
  print('Report submitted: $reportMessage');
}


  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon:  Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.grey : null,),
              
            ),
           KebabMenuWidget(onReportSubmitted: handleReportSubmitted)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //dish image
              // Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.white,
              //     ),
              //     child: Image.network("")),
              //recipe name, posted by, description
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Text("")),
              //ingredients
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Text("")),
              // rating
              Container(
                // implement the rating bar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: RatingBar(
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
              ),
              //prepatation time
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Text("")),
              //instruction
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Text("")),
              //comments
              Container(
                  child: Column(children: [
                const Text("Comments"),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Share your comment',
                    suffixIcon: Icon(Icons.add_comment),
                  ),
                ),
              ]))
            ],
          ),
        ));
  }
}
