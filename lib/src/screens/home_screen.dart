// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart
// Versión modular y simplificada: compone los
// bloques funcionales sin mover lógica aquí.
// ============================================

import 'package:flutter/material.dart'; // Importa Flutter (widgets, temas, etc.)

// Importa el widget que agrupa Info básica + Menú (antes en este archivo)
import 'area_fija/area_menu_info.dart';

// Importa el widget que contiene toda la lógica del Top 10 (API, estado, carrusel)
import 'pantallaInicio/area_top_eventos.dart';

// Importa las secciones visuales simples existentes
import 'pantallaInicio/area_sabia_que.dart';
import 'area_fija/area_banners.dart';
import 'area_fija/area_footer.dart';

// Importa los modelos usados para los banners
import '../models/app_models.dart';

// ============================================
// WIDGET PRINCIPAL: HomeScreen
// ============================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold principal de la pantalla de inicio
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco general de la pantalla
      body: SingleChildScrollView(
        // Permite scroll vertical de toda la pantalla
        physics:
            const BouncingScrollPhysics(), // Efecto de rebote en iOS/Android
        child: Column(
          children: [
            // ------------------------------------------------
            // SECCIÓN 1: Info básica (hora, clima, ciudad)
            // + Menú principal horizontal
            // (esta sección agrupa AreaInfoBasica + AreaMenu)
            // ------------------------------------------------
            const AreaMenuInfo(),

            // ------------------------------------------------
            // SECCIÓN 2: Top 10 de eventos
            // (contiene toda la lógica de carga y el carrusel)
            // ------------------------------------------------
            const AreaTopEventos(),

            // ------------------------------------------------
            // SECCIÓN 3: ¿SABÍAS QUÉ?
            // (componente simple y estático)
            // ------------------------------------------------
            const AreaSabiaQue(),

            // ------------------------------------------------
            // SECCIÓN 4: Banner "DESCUBRE"
            // (usa AreaBanners y requiere BannerData)
            // ------------------------------------------------
            AreaBanners(banners: _getBannerData()),

            // ------------------------------------------------
            // SECCIÓN 5: Footer institucional
            // ------------------------------------------------
            const AreaFooter(),

            // Espacio final debajo del footer
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ============================================
  // DATOS DE PRUEBA PARA LOS BANNERS
  // (se mantienen aquí para que Home haga la composición)
  // ============================================
  List<BannerData> _getBannerData() => [
    BannerData(
      title: 'DESCUBRE', // Título del banner
      description:
          'Descubre su encanto entre parques, montañas y senderismo, una tradición que enamora a cada visitante.', // Descripción
      buttonText: 'Ver más', // Texto del botón
      backgroundColor: '#F0C339', // Color de fondo hexadecimal
      textColor: '#08522B', // Color del texto en hexadecimal
      buttonTextColor: '#F0C339', // Color del texto del botón
      onButtonPressed: () {
        // Acción temporal vacía (puedes enlazarla a navegación)
      },
    ),
  ];
}
