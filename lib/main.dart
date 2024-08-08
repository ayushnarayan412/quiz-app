import 'package:flutter/material.dart';
import 'package:new_project/pages/home_page.dart';
import 'package:new_project/pages/intro_page.dart';
import 'package:new_project/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: ({
        '/':(context)=>const SplashScreen(),
        '/intro':(context) =>const IntroPage(),
        '/homepage':(context) =>const HomePage()
       }),
    );
  }
}
