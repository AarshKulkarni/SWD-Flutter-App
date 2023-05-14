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

  Future<List<ReqUser>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    var fetchedData = json.decode(response.body);
    if (response.statusCode == 200) {
      var data = fetchedData['data'];
      for (Map i in data) {
        ReqUser user = ReqUser(
            id: i['id'],
            email: i['email'],
            first_name: i['first_name'],
            last_name: i['last_name'],
            avatar: i['avatar']);
        reqUsers.add(user);
      }
      return reqUsers;
    } else {
      return reqUsers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SWD-App'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, AsyncSnapshot<List<ReqUser>> snapshot) {
                    return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                        itemCount: reqUsers.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            visualDensity: const VisualDensity(vertical: 4),
                            leading: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].avatar),
                            ),
                            title: Text(
                                snapshot.data![index].first_name.toString()),
                          );
                        }));
                  }),
            )
          ],
        ));
  }
}
