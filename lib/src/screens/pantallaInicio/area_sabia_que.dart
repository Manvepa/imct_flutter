// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_sabia_que.dart
// Descripción: Widget que muestra la sección informativa
// “¿SABÍAS QUÉ?” en el HomeScreen, con diseño de ancho completo.
// ============================================

import 'package:flutter/material.dart';

// ============================================
// WIDGET PRINCIPAL: AreaSabiaQue
// ============================================
class AreaSabiaQue extends StatelessWidget {
  const AreaSabiaQue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Ocupa todo el ancho disponible
      color: const Color(0xFF89C53F), // 🎨 Fondo verde claro
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ), // Espaciado interno superior, inferior y laterales
      // Contenido principal en columna (título + texto)
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea el texto a la izquierda
        children: const [
          // 🔹 Título “¿SABÍAS QUÉ?”
          Text(
            '¿SABÍAS QUÉ?',
            style: TextStyle(
              color: Color(0xFF085029), // 🎨 Color del título (#085029)
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10), // Espacio entre el título y el texto
          // 🔹 Texto descriptivo
          Text(
            'Bucaramanga tiene más de 72 parques dentro de su área metropolitana, '
            'lo que la hace una ciudad de destacado desarrollo urbano sostenible y un paisaje verde.',
            style: TextStyle(
              color: Color(0xFF08522F), // 🎨 Color del texto (#08522F)
              fontSize: 14,
              height: 1.5, // Espaciado entre líneas
            ),
          ),
        ],
      ),
    );
  }
}
