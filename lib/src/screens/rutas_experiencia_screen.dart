// ============================================
// ARCHIVO: lib/src/screens/rutas_experiencia_screen.dart
// Versión modular y simplificada: compone los
// bloques funcionales sin mover lógica aquí.
// ============================================

import 'package:flutter/material.dart';

// Importa el widget que agrupa Info básica + Menú (antes en este archivo)
import 'area_fija/header/area_menu_info.dart';

// ============================================
// WIDGET PRINCIPAL: RutasExperienciaScreen
// ============================================
class RutasExperienciaScreen extends StatelessWidget {
  const RutasExperienciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold principal de la pantalla de Rutas y Experiencias
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------------
            // SECCIÓN 1: Info básica (hora, clima, ciudad)
            // + Menú principal horizontal
            // (esta sección agrupa AreaInfoBasica + AreaMenu)
            // ------------------------------------------------
            const AreaMenuInfo(),
          ],
        ),
      ),
    );
  }
}
