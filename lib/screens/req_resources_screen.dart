import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swd_app/models/req_resource.dart';
import 'package:swd_app/screens/no_netowrk.dart';

class ResourcesListScreen extends StatefulWidget {
  const ResourcesListScreen({super.key});
  @override
  State<ResourcesListScreen> createState() {
    return _ResourcesListScreenState();
  }
}

class _ResourcesListScreenState extends State<ResourcesListScreen> {
  List<ReqResource> reqRes = [];
  Future<List<ReqResource>> fetchRes() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/unknown?page=1'));
    final response2 =
        await http.get(Uri.parse('https://reqres.in/api/unknown?page=2'));
    var fetchedRes = json.decode(response.body);
    var fetchedRes2 = json.decode(response2.body);
    if (response.statusCode == 200 && response2.statusCode == 200) {
      var data = [...fetchedRes['data'], ...fetchedRes2['data']];
      for (Map i in data) {
        ReqResource res = ReqResource(
            id: i['id'],
            name: i['name'],
            year: i['year'],
            color: i['color'],
            pantoneValue: i['pantoneValue']);
        reqRes.add(res);
      }
      return reqRes;
    } else {
      return reqRes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<ReqResource>> snapshot) {
                  return (snapshot.data == null)
                      ? const NoNetwork()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                          itemCount: reqRes.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              visualDensity: const VisualDensity(vertical: 4),
                              leading: CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Color(
                                    '0x${snapshot.data![index].color.substring(1)}'
                                        as int),
                              ),
                              title:
                                  Text(snapshot.data![index].name.toString()),
                              subtitle: Text('${snapshot.data![index].year}'),
                            );
                          }));
                },
                future: fetchRes(),
              ),
            ),
          ],
        ));
  }
}
