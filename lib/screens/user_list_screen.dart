// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swd_app/models/req_user.dart';
import 'package:swd_app/screens/no_netowrk.dart';
import 'package:swd_app/widgets/main_drawer.dart';
import 'package:swd_app/widgets/user_details.dart';
import 'package:swd_app/services/notifications_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({User? user, super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserListScreenState();
  }
}

class _UserListScreenState extends State<UserListScreen> {
  List<ReqUser> reqUsers = [];
  List<String> urls = [
    'https://reqres.in/api/users?page=1',
    'https://reqres.in/api/users?page=2'
  ];

  Future<List<ReqUser>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    final response2 =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    var fetchedData = json.decode(response.body);
    var fetchedData2 = json.decode(response2.body);
    if (response.statusCode == 200 && response2.statusCode == 200) {
      var data = [...fetchedData['data'], ...fetchedData2['data']];
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
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<ReqUser>> snapshot) {
                  return (snapshot.data == null)
                      ? const NoNetwork()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                          itemCount: reqUsers.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return UserDetails(
                                          user: snapshot.data![index]);
                                    });
                              },
                              onLongPress: () async {
                                await NotificationController().showNotification(
                                    title: 'User was clicked',
                                    body:
                                        '${snapshot.data![index].first_name} ${snapshot.data![index].last_name} was clicked');
                              },
                              visualDensity: const VisualDensity(vertical: 4),
                              leading: CircleAvatar(
                                maxRadius: 25,
                                backgroundImage:
                                    NetworkImage(snapshot.data![index].avatar),
                              ),
                              title: Text(
                                snapshot.data![index].first_name.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }));
                },
                future: fetchData(),
              ),
            ),
          ],
        ));
  }
}
