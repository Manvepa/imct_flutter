// ============================================
// ARCHIVO: lib/src/widgets/rutas/lugar_card.dart
// Componente visual de la tarjeta individual de lugar
// ============================================

import 'package:flutter/material.dart';
// Importa el modelo de datos
import '../../../models/rutasExperiencia/lugar_models.dart';

/// Widget visual de la tarjeta individual de un lugar turístico
///
/// Muestra la imagen, título, descripción e icono del lugar.
/// Es un componente stateless puramente visual.
class LugarCard extends StatelessWidget {
  final LugarTop lugar;

  const LugarCard({super.key, required this.lugar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ------------------------------------------------
            // Imagen de fondo del lugar
            // ------------------------------------------------
            Image.network(
              lugar.lugar.imagen,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: const Color(0xFF9C4F96),
                    ),
                  ),
                );
              },
            ),

            // ------------------------------------------------
            // Gradiente oscuro en la parte inferior
            // ------------------------------------------------
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

            // ------------------------------------------------
            // Contenido de texto (icono, título, descripción)
            // ------------------------------------------------
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icono circular verde
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2D5F3F),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF2D5F3F),
                        size: 35,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Título del lugar
                    Text(
                      lugar.lugar.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Descripción del lugar
                    Text(
                      lugar.lugar.descripcion,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 15,
                        height: 1.4,
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
