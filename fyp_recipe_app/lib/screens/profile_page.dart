import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';
import 'package:fyp_recipe_app/custom_widget/profile_page_topbar.dart';
import 'package:fyp_recipe_app/provider/bookmark_provider.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:provider/provider.dart';
import '../network/api_response.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const ProfileTopBar(),
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              indicatorWeight: 1,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  icon: Icon(Icons.post_add),
                ),
                Tab(
                  icon: Icon(Icons.bookmark),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text('Post tab content')),
                  BookmarkContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkContent extends StatelessWidget {
  const BookmarkContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetBookmarkProvider>(builder: (context, value, child) {
      if (value.getbookmarkResponse.status == Status.success) {
        final recipes = value.getbookmarkResponse.data!;
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            final recipe = recipes[index];
            return ListTile(
              leading: recipe.imageURL != null
                  ? Image.network(recipe.imageURL!)
                  : const Icon(Icons.image_not_supported),
              title: Text(recipe.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.recipeType),
                  Text(recipe.description),
                  Text('Prep Time: ${recipe.preptime.toString()} minutes'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipePage(
                          clickedrecipe: recipe,
                        )));
              },
            );
          },
        );
      }
      return const SizedBox(
        child: Center(child: Text('Bookmark tab content')),
      );
    });
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetBookmarkProvider>(builder: (context, value, child) {
      if (value.getbookmarkResponse.status == Status.success) {
        final recipes = value.getbookmarkResponse.data!;
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            final recipe = recipes[index];
            return ListTile(
              leading: recipe.imageURL != null
                  ? Image.network(recipe.imageURL!)
                  : const Icon(Icons.image_not_supported),
              title: Text(recipe.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.recipeType),
                  Text(recipe.description),
                  Text('Prep Time: ${recipe.preptime.toString()} minutes'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipePage(clickedrecipe: recipe)));
              },
            );
          },
        );
      }
      return const SizedBox(child: Center(child: Text('Post tab content')),);
    });
  }
}
