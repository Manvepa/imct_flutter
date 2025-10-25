// splash_screen.dart
// Esta pantalla se muestra al inicio de la aplicación.
// Sirve para mostrar un logo, imagen o animación mientras la app carga.
// Después de unos segundos, redirige automáticamente al HomeScreen.

// Importamos los paquetes necesarios de Flutter.
import 'package:flutter/material.dart'; // Para construir la interfaz.
import 'dart:async'; // Para usar temporizadores (Timer).
import 'home_screen.dart'; // Importamos la pantalla principal a la que navegaremos.

// Definimos la clase SplashScreen, que es un widget con estado (StatefulWidget)
// porque necesita controlar un temporizador y navegación.
class SplashScreen extends StatefulWidget {
  // Constructor constante.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Esta clase maneja el estado interno del SplashScreen (ejemplo: cuándo navegar al Home).
class _SplashScreenState extends State<SplashScreen> {
  // Este método se ejecuta automáticamente cuando la pantalla se inicia.
  @override
  void initState() {
    // Llamamos primero al initState original del padre.
    super.initState();

    // Usamos un temporizador (Timer) que esperará 3 segundos antes de ejecutar una acción.
    Timer(const Duration(seconds: 3), () {
      // Luego de 3 segundos, se ejecuta esta función anónima.

      // Navegamos a la pantalla principal (HomeScreen).
      // pushReplacement() reemplaza la pantalla actual (Splash) para que no se pueda volver atrás.
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute define la transición entre pantallas con estilo "Material Design".
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  // El método build() construye lo que se ve en la pantalla.
  @override
  Widget build(BuildContext context) {
    // Scaffold es la estructura base de una pantalla en Flutter (appbar, body, etc.)
    return Scaffold(
      // Definimos el color de fondo de la pantalla (blanco en este caso).
      backgroundColor: Colors.white,

      // El cuerpo (body) contendrá todo lo visible en la pantalla.
      body: Center(
        // Usamos una columna para organizar los elementos verticalmente.
        child: Column(
          // Centramos los elementos verticalmente en el centro de la pantalla.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostramos una imagen (puede ser un .gif o .png).
            // Debe estar en la carpeta assets/ y declarada en pubspec.yaml.
            Image.asset(
              'assets/logo.gif', // Ruta del logo o gif.
              width: 150, // Ancho de la imagen.
              height: 150, // Alto de la imagen.
              fit: BoxFit.contain, // Ajuste para mantener proporciones.
            ),

            // Añadimos un espacio entre la imagen y el texto.
            const SizedBox(height: 20),

            // Mostramos un texto debajo de la imagen.
            const Text(
              'Cargando...', // Texto que se muestra.
              style: TextStyle(
                fontSize: 18, // Tamaño de fuente.
                fontWeight: FontWeight.w500, // Grosor medio del texto.
                color: Colors.grey, // Color gris para el texto.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
