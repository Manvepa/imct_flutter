// home_screen.dart
// Esta es la pantalla principal que se muestra después del SplashScreen.
// Aquí irá el contenido real de la aplicación (por ahora un mensaje de bienvenida).

// Importamos el paquete de Flutter para construir interfaces.
import 'package:flutter/material.dart';

// Definimos HomeScreen como un widget sin estado (StatelessWidget)
// porque no necesita manejar cambios dinámicos por ahora.
class HomeScreen extends StatelessWidget {
  // Constructor constante.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold crea la estructura básica de la pantalla.
    return Scaffold(
      // AppBar es la barra superior que muestra el título.
      appBar: AppBar(
        // Título del AppBar.
        title: const Text('Inicio'),

        // Centra el texto del título (opcional).
        centerTitle: true,
      ),

      // El cuerpo principal de la pantalla.
      body: const Center(
        // Center centra su contenido en medio de la pantalla.
        child: Text(
          // Texto de bienvenida.
          'Bienvenido a AppMovil 🎉',

          // Estilo del texto.
          style: TextStyle(
            fontSize: 20, // Tamaño de letra.
            fontWeight: FontWeight.bold, // Texto en negrita.
          ),
        ),
      ),
    );
  }
}
