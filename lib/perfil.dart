import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  final Map<String, dynamic> usuarioPerfil;

  const PerfilScreen({super.key, required this.usuarioPerfil});

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final publicaciones = widget.usuarioPerfil['publicaciones'] as List<dynamic>;
    final seguidores = widget.usuarioPerfil['seguidores'] as List<dynamic>;
    final seguidos = widget.usuarioPerfil['seguidos'] as List<dynamic>;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Banner
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        widget.usuarioPerfil['bannerPerfil'],
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: -40,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(widget.usuarioPerfil['imagenPerfil']),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Nombre, usuario, localidad
                  Text(
                    widget.usuarioPerfil['nikname'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (widget.usuarioPerfil['verificado'])
                    const Icon(Icons.verified, color: Colors.green, size: 20),
                  const SizedBox(height: 5),
                  Text(
                    widget.usuarioPerfil['usuario'],
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.usuarioPerfil['localidad'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  // Estadísticas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('Publicaciones', publicaciones.length),
                      _buildStat('Seguidores', seguidores.length),
                      _buildStat('Seguidos', seguidos.length),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Descripción
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.usuarioPerfil['descripcion'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TabBar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Publicaciones'),
                      Tab(text: 'Retwits'),
                      Tab(text: 'Likes'),
                      Tab(text: 'Guardados'),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            BuildFeed(widget.usuarioPerfil['publicaciones']),
            BuildFeed(widget.usuarioPerfil['retwits']),
            BuildFeed(widget.usuarioPerfil['megustas']),
            BuildFeed(widget.usuarioPerfil['guardados']),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}


// Este es un widget de ejemplo para mostrar las publicaciones.


Widget BuildFeed(List publicaciones) {
  return ListView.builder(
    itemCount: publicaciones.length,
    itemBuilder: (context, index) {
      final Map<String, dynamic> publicacion = publicaciones[index];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(publicacion['imagenPerfil']),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          publicacion['nikname'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '@${publicacion['usuario']}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        if (publicacion['seguidor'] == false)
                          ElevatedButton(
                            onPressed: () {
                              // Aquí podés agregar la lógica para seguir al usuario
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              textStyle: const TextStyle(fontSize: 12, color: Colors.black),
                              backgroundColor: const Color.fromARGB(255, 174, 175, 175),
                            ),
                            child: const Text('Seguir'),
                          ),
                      ],
                    ),
                    Text(
                      publicacion['date'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(publicacion['mensaje']),
                    if (publicacion['adjunto'].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(publicacion['adjunto']),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                        ),
                        Text('${publicacion['cantidadLikes'] ?? " "}'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.repeat),
                        ),
                        Text('${publicacion['cantidadRetwits'] ?? " "}'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_border),
                        ),
                        Text('${publicacion['cantidadGuardados'] ?? " "}'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
