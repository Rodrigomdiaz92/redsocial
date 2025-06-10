import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_2/feed.dart';
import 'package:flutter_application_2/notificaciones.dart';
import 'package:flutter_application_2/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<dynamic> publicaciones = []; // Aquí guardamos las publicaciones
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarPublicaciones(); // Llamamos a la función que carga el JSON
  }

  Future<void> cargarPublicaciones() async {
    final String response =
        await rootBundle.loadString('assets/bdpublicaciones.json');
    final data = await json.decode(response);
    setState(() {
      publicaciones = data['publicaciones'];
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Mientras se cargan los datos mostramos un loading
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> _screens = [
      FeedScreen(publicaciones: publicaciones), // Pasamos los datos cargados
      BusquedaScreen(publicaciones: publicaciones.cast<Map<String, dynamic>>()),
      const Center(child: Text("Pantalla de Publicar")),
      NotificacionesWidget(),
      const Center(child: Text("Pantalla de Perfil")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("ReDsocial"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://i.ibb.co/B2Q7L3YH/vista-frontal-de-la-mujer-sonriente-con-auriculares.jpg',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("📌Guardados"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex], // Muestra la pantalla correspondiente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_square), label: "Publicar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}


