import 'package:flutter/material.dart';
import 'package:swd_app/widgets/main_drawer.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('About Me'),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hello there! I am Aarsh Kulkarni from Hyderabad. I am an avid learner //..",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      )),
    );
  }
}
