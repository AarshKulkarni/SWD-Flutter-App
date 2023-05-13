import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:swd_app/models/login_api_service.dart';
import 'package:swd_app/screens/user_list_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const FailedLogin();
          }));
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
    return Scaffold(
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
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  _callLoginApi();
                },
              ),
              const SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: () {
                    _googleSignIn.signIn().then((googleSignInAccount) {
                      if (googleSignInAccount != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const UserListScreen();
                        }));
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const FailedLogin();
                        }));
                      }
                    });
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
