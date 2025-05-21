import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_application_2/ConfirmacionReservaScreen.dart';
//import 'package:flutter_application_2/SolicitudFormScreen.dart';
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
    cargarDatos();
  }

Future<void> cargarDatos() async {
  try {
    final String response = await rootBundle.loadString('assets/db.json');
    final data = json.decode(response);

    if (data != null && data["proveedores"] != null) {
      print("Datos cargados correctamente:");
      //print(jsonEncode(data["proveedores"])); // Imprime solo el array de proveedores
    } else {
      print("Error: El JSON no contiene el array 'proveedores'.");
    }
  } catch (e) {
    print("Error al cargar el archivo JSON: $e");
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          //child: HomeScreen(),
          //child: LoginScreen(),
          //child: SolicitudFormScreen(),
          //child: ConfirmacionReservaScreen(),
          child: SplashIntroScreen(),
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedSocial',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashIntroScreen(),
        //'/home': (context) => const HomeScreen(),
        '/home': (context) => FeedScreen(),
        '/login': (context) => LoginScreen(),
        //'/solicitud': (context) => const SolicitudFormScreen (),
        //'/confirmacion': (context) => const ConfirmacionReservaScreen (),
      },
    );
  }

}
