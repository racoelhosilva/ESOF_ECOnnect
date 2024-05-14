import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<User> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        specialActions: {
          '/search': () {
            Navigator.popAndPushNamed(context, '/search');
          }
        },
      ),
      appBar: AppBar(
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          title: Column(children: [
            const HeaderWidget(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    LucideIcons.search,
                    size: 24,
                  ),
                  hintText: "Search for users",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _searchUsers(value);
                  } else {
                    setState(() {
                      _searchResults.clear();
                    });
                  }
                },
              ),
            ),
          ])),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final user = _searchResults[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePicture),
                  ),
                  title: Text(user.username),
                  subtitle: Text(user.description ?? ""),
                  trailing: FollowButton(
                      dbController: widget.dbController,
                      sessionController: widget.sessionController,
                      userId: user.id),
                  onTap: () {
                    Navigator.pushNamed(context, "/profile",
                        arguments: user.id);
                  },
                );
              },
            ),
    );
  }

  Future<void> _searchUsers(String query) async {
    setState(() {
      _isLoading = true;
    });
    final users = await widget.dbController.searchUsers(query);
    setState(() {
      _searchResults.clear();
      _searchResults.addAll(users);
      _isLoading = false;
    });
  }
}
