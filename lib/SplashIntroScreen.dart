import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashIntroScreen extends StatefulWidget {
  const SplashIntroScreen({super.key});

  @override
  State<SplashIntroScreen> createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen> {
  bool _animacionTerminada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'RED SOCIAL',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Lottie.asset(
                'assets/intro.json',
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    setState(() {
                      _animacionTerminada = true;
                    });
                  });
                },
              ),
            ),
            if (_animacionTerminada) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Omitir'),
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }
}
