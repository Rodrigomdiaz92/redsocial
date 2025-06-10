import 'package:flutter/material.dart';

class BusquedaScreen extends StatefulWidget {
  final List<Map<String, dynamic>> publicaciones;

  const BusquedaScreen({super.key, required this.publicaciones});

  @override
  State<BusquedaScreen> createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // Filtrar publicaciones por coincidencia en el nickname
    final List<Map<String, dynamic>> resultados = widget.publicaciones
        .where((pub) =>
            pub['nikname'].toLowerCase().contains(_query.toLowerCase()))
        .toList()
        .take(3)
        .toList();

    return Scaffold(
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por nickname',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: resultados.length,
              itemBuilder: (context, index) {
                final resultado = resultados[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(resultado['imagenPerfil']),
                    radius: 20,
                  ),
                  title: Text(
                    resultado['nikname'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('@${resultado['usuario']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
