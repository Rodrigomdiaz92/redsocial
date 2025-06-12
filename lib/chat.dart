import 'package:flutter/material.dart';

class MensajeriaScreen extends StatefulWidget {
  const MensajeriaScreen({super.key});

  @override
  _MensajeriaScreenState createState() => _MensajeriaScreenState();
}

class _MensajeriaScreenState extends State<MensajeriaScreen> {
  // Simulación de chats activos
  final List<Map<String, dynamic>> chats = [
    {
      'usuario': 'Juan Pérez',
      'imagen': 'https://i.ibb.co/B2Q7L3YH/vista-frontal-de-la-mujer-sonriente-con-auriculares.jpg',
      'mensajes': [
        {'texto': '¡Hola! ¿Cómo estás?', 'esMio': false},
        {'texto': 'Todo bien, ¿vos?', 'esMio': true},
        {'texto': 'Bien, gracias por preguntar.', 'esMio': false},
      ],
    },
    {
      'usuario': 'Ana López',
      'imagen': 'https://i.ibb.co/B2Q7L3YH/vista-frontal-de-la-mujer-sonriente-con-auriculares.jpg',
      'mensajes': [
        {'texto': '¿A qué hora jugamos mañana?', 'esMio': false},
        {'texto': 'A las 18 hs!', 'esMio': true},
      ],
    },
  ];

  int? chatSeleccionado;

  final TextEditingController _mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatSeleccionado == null ? 'Mensajes' : chats[chatSeleccionado!]['usuario']),
        leading: chatSeleccionado != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    chatSeleccionado = null;
                  });
                },
              )
            : null,
      ),
      body: chatSeleccionado == null ? _buildChatList() : _buildChatDetail(),
    );
  }

  // Lista de chats activos
  Widget _buildChatList() {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat['imagen']),
          ),
          title: Text(chat['usuario']),
          subtitle: Text(chat['mensajes'].last['texto']),
          onTap: () {
            setState(() {
              chatSeleccionado = index;
            });
          },
        );
      },
    );
  }

  // Conversación seleccionada
  Widget _buildChatDetail() {
    final mensajes = chats[chatSeleccionado!]['mensajes'] as List<dynamic>;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: mensajes.length,
            itemBuilder: (context, index) {
              final mensaje = mensajes[index];
              return Align(
                alignment: mensaje['esMio'] ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: mensaje['esMio'] ? Colors.blue[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(mensaje['texto']),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _mensajeController,
                  decoration: const InputDecoration(
                    hintText: 'Escribe un mensaje...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Por ahora no hacemos nada
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
