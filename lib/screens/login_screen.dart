import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:swd_app/models/login_api_service.dart';
import 'package:swd_app/screens/user_list_screen.dart';
import 'package:swd_app/widgets/google_sign_in_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  String hintPasswordText = 'password';
  void _callLoginApi() {
    final service = ApiServices();
    setState(() {
      service.apiCallLogin({
        'email': emailText.text,
        'password': passwordText.text
      }).then((value) {
        if (value.error != null) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Login Failed'),
                  content: Text(
                    'Check password and email',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ok'))
                  ],
                );
              });
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const UserListScreen();
          }));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null)
        ? const UserListScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailText,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text('Email'),
                        hintText: 'Enter your email'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordText,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: const Text('Password'),
                        hintText: hintPasswordText),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            _callLoginApi();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const GoogleLogin())));
                            },
                            child: const Text('Sign in with Google'))
                      ]),
                ]),
              ),
            ),
          );
  }
}

class FailedLogin extends StatelessWidget {
  const FailedLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
            child: Text(
          'Oh No! Login Failed, Please try again',
          style: Theme.of(context).textTheme.labelLarge,
        )));
  }
}
