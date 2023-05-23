import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swd_app/models/req_resource.dart';
import 'package:swd_app/screens/no_netowrk.dart';
import 'package:swd_app/widgets/main_drawer.dart';
import 'package:swd_app/widgets/req_res_details.dart';

class ResourcesListScreen extends StatefulWidget {
  const ResourcesListScreen({super.key});
  @override
  State<ResourcesListScreen> createState() {
    return _ResourcesListScreenState();
  }
}

class _ResourcesListScreenState extends State<ResourcesListScreen> {
  List<ReqResource> reqRes = [];

  Future<List<ReqResource>> fetchResources() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/unknown?page=1'));
    final resopnse2 =
        await http.get(Uri.parse('https://reqres.in/api/unknown?page=2'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final jsonData2 = json.decode(resopnse2.body);

      final List<dynamic> resourceData = [
        ...jsonData['data'],
        ...jsonData2['data']
      ];
      for (var res in resourceData) {
        ReqResource resource = ReqResource(
            id: res['id'],
            name: res['name'],
            year: res['year'],
            color: res['color'],
            pantoneValue: res['pantone_value']);

        reqRes.add(resource);
      }
      return reqRes;
    } else {
      throw Exception('Failed to fetch resources');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          title: const Text('Resources'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ReqResource>>(
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
                            return ResDetails(res: snapshot.data![index]);
                          }));
                },
                future: fetchResources(),
              ),
            ),
          ],
        ));
  }
}
