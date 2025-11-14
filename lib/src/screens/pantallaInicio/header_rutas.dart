// ============================================
// ARCHIVO: lib/src/widgets/rutas/header_rutas.dart
// Componente visual simple del header
// ============================================

import 'package:flutter/material.dart';

/// Widget del header para la pantalla de Rutas y Experiencias
///
/// Muestra el título de la sección y un botón circular de regreso.
/// Es un componente stateless sin lógica compleja.
class HeaderRutas extends StatelessWidget {
  const HeaderRutas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ------------------------------------------------
          // Título de la sección
          // ------------------------------------------------
          const Expanded(
            child: Text(
              'Rutas y Experiencias',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // ------------------------------------------------
          // Botón circular de regreso
          // ------------------------------------------------
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF9C4F96),
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
