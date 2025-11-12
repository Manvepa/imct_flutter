// ============================================
// ARCHIVO: lib/src/screens/rutas_experiencia_screen.dart
// Versión modular y simplificada: compone los
// bloques funcionales sin mover lógica aquí.
// ============================================

import 'package:flutter/material.dart';

// Importa el widget que agrupa Info básica + Menú (antes en este archivo)
import 'area_fija/header/area_menu_info.dart';

// Importa el widget del header con título y botón de regreso
import 'rutasExperiencias/carousel/header_rutas.dart';
// Importa el widget que contiene toda la lógica del carousel (API, estado, PageView)
import 'rutasExperiencias/carousel/area_lugares_carousel.dart';

// Importamos el nuevo widget FooterBackground
import 'area_fija/footer/footer_background.dart';

// Importa la sección visual simple del footer institucional
import 'area_fija/footer/area_footer.dart';

// Importa la sección visual simple del footer institucional
import 'area_fija/footer/area_banners.dart';

// Importamos el widget visual simple de la sección ¿SABÍAS QUÉ? de Carousel
import 'rutasExperiencias/carousel/area_sabia_que.dart';

// Importa los modelos usados para los banners
import '../models/app_models.dart';

// ============================================
// WIDGET PRINCIPAL: RutasExperienciaScreen
// ============================================
class RutasExperienciaScreen extends StatelessWidget {
  const RutasExperienciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold principal de la pantalla de Rutas y Experiencias
    return Scaffold(
      backgroundColor: const Color(0xFF883795),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AreaMenuInfo(),
              HeaderRutas(),
              SizedBox(height: 40),
              AreaLugaresCarousel(),
              AreaSabiaQue(),
              AreaBanners(banners: _getBannerData()),
              AreaFooter(),
              FooterBackground(),
            ],
          ),
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
          'BARICHARA: El pueblo mas bonito de Colombia a 3 horas de Bucaramanga.', // Descripción
      buttonText: 'Ver más', // Texto del botón
      backgroundColor: '#1CA3DC', // Color de fondo hexadecimal
      textColor: '#FFFFFF', // Color del texto en hexadecimal
      buttonTextColor: '#1CA3DC', // Color del texto del botón
      onButtonPressed: () {
        // Acción temporal vacía (puedes enlazarla a navegación)
      },
    ),
  ];
}
