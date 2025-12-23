import 'package:flutter/material.dart';
import 'package:jura/views/home_page.dart';
import 'package:jura/views/initial_page.dart';
import 'package:jura/views/login_page.dart';
import 'package:jura/views/signup_page.dart';

class JurApp extends StatelessWidget {
  const JurApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JurApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => const InitialPage(),
        '/loginPage': (context) => const LoginPage(),
        '/homePage': (context) => const HomePage(),
        '/signUpPage': (context) => const SignUpPage(),
      }
    );
  }
}