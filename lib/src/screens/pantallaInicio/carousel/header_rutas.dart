// ============================================
// ARCHIVO: lib/src/widgets/rutas/header_rutas.dart
// Componente visual del header para la pantalla de Rutas y Experiencias
// ============================================

import 'package:flutter/material.dart'; // Importa el paquete base de Flutter para usar widgets visuales

/// Widget sin estado (StatelessWidget) que representa el encabezado
/// de la pantalla de Rutas y Experiencias.
class HeaderRutas extends StatelessWidget {
  // Constructor constante del widget
  const HeaderRutas({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget principal que devuelve la estructura visual
    return Padding(
      // Padding aplica espacio alrededor del contenido
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

      // Row organiza los elementos en una fila horizontal
      child: Row(
        // Distribuye los elementos con espacio entre ellos
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        // Lista de widgets hijos dentro de la fila
        children: [
          // Expanded hace que el contenido interno ocupe todo el espacio disponible
          Expanded(
            // Stack permite superponer widgets uno encima de otro
            child: Stack(
              // Evita que los widgets dentro del Stack se recorten si salen del área
              clipBehavior: Clip.none,

              // Lista de widgets dentro del Stack (uno encima de otro)
              children: [
                // -------------------------------
                // Texto principal del encabezado
                // -------------------------------
                const Text(
                  // Contenido del texto
                  'Top 10 para visitar',
                  // Estilo visual del texto
                  style: TextStyle(
                    color: Colors.white, // Color blanco para el texto principal
                    fontSize: 32, // Tamaño de fuente grande
                    fontWeight: FontWeight.bold, // Texto en negrita
                    letterSpacing: -0.5, // Ajuste del espaciado entre letras
                  ),
                ),

                // ---------------------------------------------------------
                // Texto secundario "En familia" posicionado debajo de "para"
                // ---------------------------------------------------------
                Positioned(
                  // Desplaza el texto hacia la derecha (ajustar este valor según fuente)
                  left: 178,

                  // Desplaza el texto hacia abajo respecto al texto principal
                  top: 36,

                  // Texto "En familia"
                  child: const Text(
                    'En familia',
                    // Estilo visual del texto "En familia"
                    style: TextStyle(
                      color: Color(
                        0xFF89C53E,
                      ), // Color verde claro personalizado
                      fontSize: 32, // Tamaño de fuente más pequeño
                      fontWeight: FontWeight.bold, // Texto en negrita
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Espacio adicional a la derecha del título
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
