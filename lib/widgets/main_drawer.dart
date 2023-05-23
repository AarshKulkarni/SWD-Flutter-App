import 'package:flutter/material.dart';
import 'package:swd_app/authentication.dart';
import 'package:swd_app/screens/about_me.dart';
import 'package:swd_app/screens/login_screen.dart';
import 'package:swd_app/screens/req_resources_screen.dart';
import 'package:swd_app/screens/user_list_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Row(
            children: [
              Icon(
                Icons.android,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 18),
              Text(
                'Plz Induct ;-;',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Reqres Users',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const UserListScreen();
            }));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.water_drop_rounded,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Reqres Resources',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ResourcesListScreen();
            }));
          },
        ),
        ListTile(
            leading: Icon(
              Icons.account_circle_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'About Me',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const AboutMe();
              }));
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        ListTile(
          leading: Icon(
            Icons.logout_rounded,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'LogOut',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24),
          ),
          onTap: () {
            Authentication.signOut(context: context);
            Authentication.signOut(context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false);
          },
        )
      ]),
    );
  }
}
