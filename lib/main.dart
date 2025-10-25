// main.dart
// Este archivo es el punto de entrada principal de la aplicación Flutter.
// Desde aquí se ejecuta la app, se configura el tema visual y se define
// cuál será la primera pantalla (SplashScreen).

// Importamos el paquete principal de Flutter para construir interfaces de usuario.
import 'package:flutter/material.dart';

// Importamos la pantalla inicial (SplashScreen) que mostraremos al arrancar la app.
import 'src/screens/splash_screen.dart';

// La función main() es la que se ejecuta al iniciar la aplicación.
void main() {
  // runApp() recibe un widget (en este caso MyApp) y lo convierte en la raíz de la interfaz.
  runApp(const MyApp());
}

// Definimos la clase MyApp, que es un widget sin estado (StatelessWidget).
// Representa la estructura global de la aplicación.
class MyApp extends StatelessWidget {
  // Constructor constante (super.key permite a Flutter identificar el widget en el árbol).
  const MyApp({super.key});

  // El método build() se ejecuta para construir la interfaz gráfica.
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget raíz que provee configuración global de la app:
    // tema, título, rutas y pantalla inicial.
    return MaterialApp(
      // Ocultamos la etiqueta "DEBUG" que aparece por defecto en la esquina superior derecha.
      debugShowCheckedModeBanner: false,

      // Título de la aplicación (usado internamente por Flutter).
      title: 'AppMovil',

      // Definimos el tema visual (colores, estilos, tipografías, etc.).
      theme: ThemeData(
        // Establece un color principal (azul en este caso).
        primarySwatch: Colors.blue,
      ),

      // Definimos cuál será la primera pantalla que se muestra al iniciar la app.
      // En este caso, la pantalla de carga (SplashScreen).
      home: const SplashScreen(),
    );
  }
}
