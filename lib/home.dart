import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/home%20copy%202.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(),
    Center(child: Text("Pantalla de Búsqueda")),
    Center(child: Text("Pantalla de Publicar")),
    Center(child: Text("Pantalla de Notificaciones")),
    Center(child: Text("Pantalla de Perfil")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("RedSocial"),
          bottom: _selectedIndex == 0
              ? const TabBar(
                  tabs: [
                    Tab(text: 'Para ti'),
                    Tab(text: 'Seguidos'),
                  ],
                )
              : null,
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(child: Text("Menú")),
              ListTile(title: Text("Opción 1")),
            ],
          ),
        ),
        body: _selectedIndex == 0
            ? const HomeContent()
            : _screens[_selectedIndex],
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
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<dynamic> canchas = [];
  List<dynamic> filteredCanchas = [];

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final String response = await rootBundle.loadString('assets/db.json');
    final data = json.decode(response);
    setState(() {
      canchas = data["proveedores"];
      filteredCanchas = canchas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return homefeed(filteredCanchas: filteredCanchas);
  }
}
