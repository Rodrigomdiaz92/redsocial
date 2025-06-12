import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final List publicaciones;

  const FeedScreen({super.key, required this.publicaciones});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}


class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        //title: const Text('Feed'),
        
      ),*/
      body: Column(
        children: [
          TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Para ti'),
            Tab(text: 'Seguidos'),
          ],
        ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BuildFeed(widget.publicaciones),
                BuildFeed(widget.publicaciones.where((pub) => pub['seguidor'] == true).toList()),
              ],
            ),
            
          ),
        ],
      ),
    );
  }

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
                                  //  agregar la lógica para seguir al usuario
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
                          Text('${publicacion['cantidadLikes']?? " "}'),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.repeat),
                          ),
                          Text('${publicacion['cantidadRetwits']?? " "}'),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_border),
                          ),
                          Text('${publicacion['cantidadGuardados']?? " "}'),
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
}
