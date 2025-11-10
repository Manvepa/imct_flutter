// 📁 lib/src/screens/pantallaInicio/area_footer.dart
// ------------------------------------------------------------
// Sección de pie de página (Footer) de la app IMCT.
// Muestra íconos de Hoteles, Restaurantes, Relax y Ecoturismo,
// con fondo color #CBE6D3, ajustado para no interferir con
// el resto del contenido.
// ------------------------------------------------------------

import 'package:flutter/material.dart';

class AreaFooter extends StatelessWidget {
  const AreaFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 🎨 Fondo verde claro
      color: const Color(0xFFCBE6D3),

      // 🔹 Ocupa todo el ancho disponible
      width: double.infinity,

      // 🔹 Padding para que el contenido respire visualmente
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),

      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ Solo ocupa el alto necesario
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ Título superior
          Text(
            'Descubre más lugares',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // 🟩 Fila (envolvente) con los íconos principales
          Wrap(
            spacing: 32,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildCategoryItem(Icons.hotel, 'Hoteles'),
              _buildCategoryItem(Icons.restaurant, 'Restaurantes'),
              _buildCategoryItem(Icons.spa, 'Relax'),
              _buildCategoryItem(Icons.park, 'Ecoturismo'),
            ],
          ),

          const SizedBox(height: 24),

          // 🌄 Imagen decorativa temporal (puedes cambiarla luego)
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  // 🔗 Imagen temporal (puedes reemplazarla por tu recurso local)
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 📜 Texto pequeño al final
          const Text(
            '© 2025 Instituto Municipal de Cultura y Turismo',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Método auxiliar que crea cada ícono con su etiqueta
  // ------------------------------------------------------------
  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔘 Círculo con el ícono
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
        const SizedBox(height: 6),
        // 🏷️ Etiqueta debajo del ícono
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
