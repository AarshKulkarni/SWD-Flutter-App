import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swd_app/models/req_resource.dart';
import 'package:swd_app/screens/no_netowrk.dart';
import 'package:swd_app/widgets/main_drawer.dart';

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

  int getColor(String s) {
    var color = s.toUpperCase().replaceAll("#", "0xFF");
    return int.parse(color);
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
                            return ListTile(
                              visualDensity: const VisualDensity(vertical: 4),
                              title: Text(
                                snapshot.data![index].name.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Year: ${snapshot.data![index].year}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      'Pantone Value: ${snapshot.data![index].pantoneValue}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            );
                          }));
                },
                future: fetchResources(),
              ),
            ),
          ],
        ));
  }
  /*Color _getColor() {
    var hex = resource.color.toUpperCase().replaceAll("#", "0xFF");
    return Color(int.parse(hex));
  }*/
}
