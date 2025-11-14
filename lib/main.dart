import 'package:flutter/material.dart';

// Importa las pantallas necesarias
import 'src/screens/splash_screen.dart';
// import 'src/screens/rutas_experiencia_screen.dart'; // Ruta de Rutas y Experiencias
import 'src/screens/home_screen.dart'; // Ruta al HomeScreen

// Importa el cliente Dio para manejar las peticiones HTTP.
import 'src/api/dio_client.dart';

void main() {
  // Inicializar interceptores de Dio
  DioClient.initializeInterceptors();

  // Ejecuta la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppMovil',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Configura las rutas de la aplicación
      routes: {
        '/': (context) => const SplashScreen(), // Pantalla inicial
        '/home': (context) => const HomeScreen(), // Ruta a HomeScreen
        // '/rutasExperiencias': (context) =>
        // const RutasExperienciaScreen(), // Ruta a Rutas y Experiencias
      },
      initialRoute: '/', // Ruta inicial (SplashScreen)
    );
  }
}
