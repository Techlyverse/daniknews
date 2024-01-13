import 'package:daniknews/auth/login_page.dart';
import 'package:daniknews/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    minRadius: 50,
                    maxRadius: 60,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Welcome to Danik news",
                        style: TextStyle(fontSize: 26)),
                  ),
                  const Text("short news video app",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: reddish)),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(height: 50),
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey[50],
                                height: 420,
                                padding: const EdgeInsets.all(20),
                                child: const UserAgreement(),
                              );
                            });
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
