import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/postcard.dart';



  class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<dynamic> canchas = [];
  List<dynamic> filteredCanchas = [];
  String selectedDeporte = "Todos";

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

  void filtrarCanchas(String deporte) {
    setState(() {
      selectedDeporte = deporte;
      filteredCanchas = deporte == "Todos"
          ? canchas
          : canchas.where((cancha) => cancha["especialidades"].contains(deporte)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("RedSocial"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Para ti'),
              Tab(text: 'Seguidos'),
            ],
          ),
          
        ),
        drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("Menú"),
            ),
            ListTile(
              title: const Text("Opción 1"),
              onTap: () {},
            ),
          ],
        ),
      ),
        body: homefeed(filteredCanchas: filteredCanchas),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.edit_square), label: "Publicar"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
      ),
    );
  }
}

class homefeed extends StatelessWidget {
  const homefeed({
    super.key,
    required this.filteredCanchas,
  });

  final List filteredCanchas;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Tab "Para ti"
        Center(child: Feed(filteredCanchas: filteredCanchas)),
        // Tab "Seguidos"
        Center(child: Feed(filteredCanchas: filteredCanchas)),
      ],
    );
  }
}


class Feed extends StatelessWidget {
  const Feed({
    super.key,
    required this.filteredCanchas,
  });

  final List filteredCanchas;

  @override  
  Widget build(BuildContext context) {
  return Expanded(
    child: ListView.builder(
      itemCount: filteredCanchas.length,
      itemBuilder: (context, index) {
        final cancha = filteredCanchas[index];
        return PostCard(
          username: cancha["nombreProveedor"] ?? "Usuario",
          handle: cancha["usuario"] ?? "usuario",
          time: cancha["tiempo"] ?? "2h",
          content: cancha["contenido"] ?? "Hola, soy un mensaje de prueba",
          avatarUrl: cancha["imagenPerfil"] ?? "https://via.placeholder.com/150",
          replies: cancha["respuestas"] ?? 10,
          retweets: cancha["retweets"] ?? 100,
          likes: cancha["likes"] ?? 10,
          views: cancha["vistas"] ?? "80",
        );
      },
    ),
  );
}

}