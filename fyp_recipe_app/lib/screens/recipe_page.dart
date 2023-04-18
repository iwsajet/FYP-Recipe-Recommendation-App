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
    bookmarkProvider.removeListener(bookmarkListner);
    commentProvider.removeListener(commentListner);
    super.dispose();
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
              onPressed: () {
                context.read<BookmarkProvider>().bookmark(
                      recipeID: widget.clickedrecipe.id,
                      userId:
                          context.read<LoginProvider>().loginResponse.data!.id,
                    );

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
                            : 'http://192.168.1.109:3000/' +
                                widget.clickedrecipe.imageURL!,
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              //recipe name, description
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name of dish:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColor.textColor),
                        ),
                        Text(
                          widget.clickedrecipe.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          "Description:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColor.textColor),
                        ),
                        Text(widget.clickedrecipe.description,
                            style: const TextStyle(fontSize: 15)),
                      ],
                    )),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              //prepatation time
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Prep Time: ${widget.clickedrecipe.preptime.toString()} minutes',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.textColor),
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
              // ingredients
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Ingredients",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColor.textColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...widget.clickedrecipe.ingredients
                            .map((e) => ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  title: Row(
                                    children: [
                                      Expanded(child: Text(e.name)),
                                      Expanded(child: Text(e.quantity)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ]),
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
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                "Instructions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColor.textColor),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...widget.clickedrecipe.instruction
                                .map((e) => ListTile(
                                      leading: const Icon(Icons.arrow_right),
                                      title: Expanded(child: Text(e)),
                                    ))
                                .toList(),
                          ]),
                    )),
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 10,
            )),
            SliverToBoxAdapter(
              // rating
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 180,
                child: Rating(
                  recipeId: widget.clickedrecipe.id,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Comment Section",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      color: Colors.white,
                      child: Text(
                        _comments[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                  childCount: _comments.length,
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
                    final fullname = context
                        .read<LoginProvider>()
                        .loginResponse
                        .data!
                        .fullname;

                    if (comment.isNotEmpty) {
                      _comments.add('$fullname: $comment');

                      _commentController.clear();
                    }
                  });
                },
                child: const Text('Post Comment'),
              ),
            ),
          ],
        ));
  }
}
