import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_properties.dart';
import '../network/api_response.dart';
import '../provider/comment_provider.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.recipeId,
  });
  final String recipeId;
  @override
  // ignore: library_private_types_in_public_api
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: TextField(
          controller: _commentController,
          decoration: const InputDecoration(
              hintText: 'Comment',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColor.secondary))),
        )),
        SliverToBoxAdapter(
          child: ElevatedButton(
            onPressed: () {
              context.read<CommentProvider>().comment(
                    comment: _commentController.text,
                    recipeId: widget.recipeId,
                    userId: '', 
                  );
              setState(() {
                final comment = _commentController.text.trim();
                if (comment.isNotEmpty) {
                  _comments.add(comment);

                  _commentController.clear();
                }
              });
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
    );
  }
}
