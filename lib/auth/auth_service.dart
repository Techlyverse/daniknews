import 'package:daniknews/auth/splash_screen.dart';
import 'package:daniknews/auth/welcome_page.dart';
import 'package:daniknews/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService extends StatelessWidget {
  const AuthService({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){return const SplashScreen();}
      else if(snapshot.data != null){
        return const Homepage();
      }
      else{
        return const LoginPage();
      }
    });
  }
}