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
      appBar: AppBar(
        //title: const Text('Feed'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Para ti'),
            Tab(text: 'Seguidos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeed(widget.publicaciones),
          _buildFeed(widget.publicaciones.where((pub) => pub['seguidor'] == true).toList()),
        ],
      ),
    );
  }

  Widget _buildFeed(List publicaciones) {
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
                          Text('${publicacion['cantidad likes']}'),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.repeat),
                          ),
                          Text('${publicacion['cantidad retwits']}'),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_border),
                          ),
                          Text('${publicacion['cantidad guardados']}'),
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
