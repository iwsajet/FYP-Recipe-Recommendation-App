import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/kebab_menu.dart';
import 'package:fyp_recipe_app/provider/bookmark_provider.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../Network/api_const.dart';
import '../app_properties.dart';
import '../custom_widget/rating.dart';
import '../models/recipe_model.dart';
import '../network/api_response.dart';
import '../provider/comment_provider.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.clickedrecipe});
  final RecipeModel clickedrecipe;
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  double? _ratingValue;
  bool isBookmarked = false;
  late final BookmarkProvider bookmarkProvider;
  final List<String> _comments = [];
  late final _commentController = TextEditingController();
  late final CommentProvider commentProvider;
  void commentListner() async {
    if (commentProvider.commentResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(commentProvider.commentResponse.error.toString())));
    } else if (commentProvider.commentResponse.status == Status.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Comment has been added.")));
    }
  }

  void bookmarkListner() async {
    if (bookmarkProvider.bookmarkResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(bookmarkProvider.bookmarkResponse.error.toString())));
    } else if (bookmarkProvider.bookmarkResponse.status == Status.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Bookmark has been added.")));
    }
  }

  @override
  void initState() {
    bookmarkProvider = context.read<BookmarkProvider>();
    bookmarkProvider.addListener(bookmarkListner);
    commentProvider = context.read<CommentProvider>();
    commentProvider.addListener(commentListner);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   
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
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed:
                  // toggleBookmark,
                  () {
                context.read<BookmarkProvider>().bookmark(
                      recipeID: widget.clickedrecipe.id,
                      userId:
                          context.read<LoginProvider>().loginResponse.data!.id,
                    );
                // toggleBookmark;
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? Colors.green[700] : null,
              ),
            ),
            KebabMenuWidget(
              recipeId: widget.clickedrecipe.id,
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              //dish image
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: widget.clickedrecipe.imageURL != null
                    ? Image.network(
                        widget.clickedrecipe.imageURL!.startsWith('http')
                            ? widget.clickedrecipe.imageURL!
                            : '${ApiConst.baseURL}' +
                                widget.clickedrecipe.imageURL!,
                        //height: 120,
                        //fit: BoxFit.contain,
                      )
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            SliverToBoxAdapter(
              //recipe name, description
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text("Name of dish"),
                      Text(widget.clickedrecipe.name),
                      const Text("Description:"),
                      Text(widget.clickedrecipe.description),
                    ],
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              //prepatation time
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                    'Prep Time: ${widget.clickedrecipe.preptime.toString()} minutes'),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              // ingredients
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: widget.clickedrecipe.ingredients
                        .map((e) => Row(
                              children: [
                                Text(e.name),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(e.quantity),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              //instruction
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: widget.clickedrecipe.instruction
                          .map((e) => Row(
                                children: [
                                  Text(e),
                                ],
                              ))
                          .toList(),
                    )),
              ),
            ),
            SliverToBoxAdapter(
              // rating
              child: Container(
                margin: const EdgeInsets.only(left: 75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 200,
                child: Rating(
                  recipeId: widget.clickedrecipe.id,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                  hintText: 'Comment',
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.secondary))),
            )),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  context.read<CommentProvider>().comment(
                      comment: _commentController.text,
                      userId:
                          context.read<LoginProvider>().loginResponse.data!.id,
                      recipeId: widget.clickedrecipe.id);
                  setState(() {
                    final comment = _commentController.text.trim();
                    // final fullname = fullname.text();
                    if (comment.isNotEmpty) {
                      _comments.add('$comment');

                      _commentController.clear();
                    }
                  }
                  );
                },
                child: const Text('Post Comment'),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "Comment Section",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Text(
                      _comments[index],
                      style: const TextStyle(fontSize: 18),
                    );
                  },
                  childCount: _comments.length,
                ),
              ),
            ),
          ],
        ));
  }
}
