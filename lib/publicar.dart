import 'package:flutter/material.dart';

class PublicarScreen extends StatefulWidget {
  const PublicarScreen({super.key});

  @override
  State<PublicarScreen> createState() => _PublicarScreenState();
}

class _PublicarScreenState extends State<PublicarScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Para que el teclado no tape contenido
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/images/homedeco.jpg'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null, // Para que crezca al escribir
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: 'Cuéntame, ¿qué sientes?',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Botones inferiores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Adjuntar imagen
                        },
                        icon: const Icon(Icons.image),
                      ),
                      IconButton(
                        onPressed: () {
                          // Localización
                        },
                        icon: const Icon(Icons.location_on),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción publicar
                    },
                    child: const Text('Publicar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
