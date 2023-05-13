import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swd_app/models/req_user.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserListScreenState();
  }
}

class _UserListScreenState extends State<UserListScreen> {
  List<ReqUser> reqUsers = [];

  Future fetchData() async {
    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final resData = Map<String, Object>.from(json.decode(response.body));
      final data = resData['data'];
      final userMap = List<Map>.from(data as List<dynamic>);
      final users = userMap.map((user) {
        return ReqUser(
            id: user['id'] as int,
            email: user['email'] as String,
            first_name: user['first_name'] as String,
            last_name: user['last_name'] as String,
            avatar: user['avatar']) as String;
      }).toList();

    } else {
      throw Exception('Failed to fetch users');
    }
  }
//Doesnt work why??
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SWD-App'),
      ),
      body: ListView.builder(
        itemCount: reqUsers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(reqUsers[index].avatar),
              ),
              title: Text(
                  '${reqUsers[index].first_name} ${reqUsers[index].last_name}'),
              subtitle: Text(reqUsers[index].email),
            ),
          );
        },
      ),
    );
  }
}
