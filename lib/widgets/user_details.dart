import 'package:flutter/material.dart';
import 'package:swd_app/models/req_user.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({required this.user, super.key});
  final ReqUser user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6.5,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange, Color.fromARGB(255, 226, 189, 79)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${user.first_name} ${user.last_name}",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  user.email,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
          Positioned(
              top: 7,
              child: CircleAvatar(
                radius: 55,
                foregroundImage: NetworkImage(user.avatar),
              ))
        ],
      ),
    );
  }
}
