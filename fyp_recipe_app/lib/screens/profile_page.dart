import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';
import 'package:fyp_recipe_app/custom_widget/profile_page_topbar.dart';


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
                  Center(child: Text('Bookmark tab content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
