
import 'package:flutter/material.dart';
import 'package:flutter_application_2/SplashIntroScreen.dart';
import 'package:flutter_application_2/home.dart';
import 'package:flutter_application_2/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedSocial',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashIntroScreen(),        
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        
      },
    );
  }

}
