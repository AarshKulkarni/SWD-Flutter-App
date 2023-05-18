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
          child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 2.7,
                backgroundImage: const AssetImage('lib/assets/avatar.jpg'),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Hello there! I am Aarsh Kulkarni. I am a CSE Student at BITS Hyderabad. I am from Hyderabad as well :). I am always looking forward to seeking new oppurtunities and solving various problems.I am always in the search of developing new skills.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
