import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {Key? key, required this.dbController, required this.sessionController})
      : super(key: key);

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
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Search for users",
            border: InputBorder.none,
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
                  onTap: () {
                    Navigator.pushNamed(context, "/profile/${user.id}");
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
    final users = <User>[];
    setState(() {
      _searchResults.clear();
      _searchResults.addAll(users);
      _isLoading = false;
    });
  }
}
