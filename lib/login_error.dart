import 'package:flutter/material.dart';

class LoginError extends StatelessWidget {
  const LoginError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login hi nhi ho rha :("),
      ),
    );
  }
}
