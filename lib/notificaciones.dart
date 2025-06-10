import 'package:flutter/material.dart';

class NotificacionesWidget extends StatelessWidget {
  final List<Map<String, String>> notificaciones = [
  {
    'titulo': '🌟 Mensaje del día',
    'descripcion': 'Hoy es un gran día para sonreír. ¡Confía en ti y sigue brillando!',
    'fecha': '09/06/2025',
  },
  {
    'titulo': '🎉 Nuevo seguidor',
    'descripcion': 'Valentina empezó a seguirte. ¡Tu comunidad sigue creciendo!',
    'fecha': '09/06/2025',
  },
  {
    'titulo': '🔁 Retuit recibido',
    'descripcion': 'Tu publicación “Nada como empezar el lunes con energía” fue retuiteada por Andrés.',
    'fecha': '08/06/2025',
  },
  {
    'titulo': '❤️ Likes nuevos',
    'descripcion': '¡5 usuarios le dieron like a tu publicación más reciente!',
    'fecha': '08/06/2025',
  },
  {
    'titulo': '👥 Sugerencia de amistad',
    'descripcion': '¿Conoces a Laura? Tienen intereses en común. ¡Conéctense!',
    'fecha': '07/06/2025',
  },
  {
    'titulo': '☀️ Ánimo para hoy',
    'descripcion': 'Cada paso cuenta. ¡Sigue avanzando, lo estás haciendo increíble!',
    'fecha': '07/06/2025',
  },
  {
    'titulo': '📣 Retuit destacado',
    'descripcion': 'Tu reflexión sobre “cuidar de uno mismo” fue compartida por un usuario popular.',
    'fecha': '06/06/2025',
  },
  {
    'titulo': '👏 Nuevo reconocimiento',
    'descripcion': 'Tu post recibió 20 likes en menos de una hora. ¡Increíble!',
    'fecha': '06/06/2025',
  },
  {
    'titulo': '🔍 Usuario recomendado',
    'descripcion': 'Sigue a Diego, comparte contenido que te podría gustar.',
    'fecha': '05/06/2025',
  },
  {
    'titulo': '🌈 Energía positiva',
    'descripcion': 'Respira profundo, piensa en algo que amas y sonríe. ¡Tú puedes!',
    'fecha': '05/06/2025',
  },
]
;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: notificaciones.length,
      itemBuilder: (context, index) {
        final notificacion = notificaciones[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.blueAccent, size: 30),
            title: Text(notificacion['titulo']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(notificacion['descripcion']!),
                SizedBox(height: 5),
                Text(
                  notificacion['fecha']!,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    )
    );
  }
}



/*
ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: notificaciones.length,
      itemBuilder: (context, index) {
        final notificacion = notificaciones[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.blueAccent, size: 30),
            title: Text(notificacion['titulo']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(notificacion['descripcion']!),
                SizedBox(height: 5),
                Text(
                  notificacion['fecha']!,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
*/