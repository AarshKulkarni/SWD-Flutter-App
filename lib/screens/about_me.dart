import 'package:flutter/material.dart';
import 'package:swd_app/widgets/main_drawer.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('About Me'),
      ),
    );
  }
}
