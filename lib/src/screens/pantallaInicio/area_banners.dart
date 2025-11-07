// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_banners.dart
// Descripción: Sección de banners tipo “DESCUBRE”
// con diseño dividido en dos trapecios (información e imagen).
// El trapecio de información ocupa más espacio que el de fondo.
// ============================================

import 'package:flutter/material.dart';
import '../../models/app_models.dart'; // Importamos el modelo BannerData

// ============================================
// WIDGET PRINCIPAL: AreaBanners
// ============================================
class AreaBanners extends StatelessWidget {
  // Lista de banners que se mostrarán
  final List<BannerData> banners;

  // Constructor con parámetro obligatorio
  const AreaBanners({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    // Retorna una columna con todos los banners
    return Column(
      children: banners.map((banner) => _buildBanner(context, banner)).toList(),
    );
  }

  // ============================================
  // MÉTODO PRIVADO: Construcción visual de cada banner
  // ============================================
  Widget _buildBanner(BuildContext context, BannerData banner) {
    return SizedBox(
      width: double.infinity, // ✅ Ocupa todo el ancho disponible
      height: 300, // Altura del bloque
      child: Row(
        children: [
          // 🟨 LADO IZQUIERDO: Trapecio grande con información
          Expanded(
            flex: 3, // ✅ Ocupa el 60% aprox. del ancho total
            child: ClipPath(
              clipper: LeftTrapezoidClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(
                    _hexToColor(banner.backgroundColor),
                  ), // Fondo amarillo
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Título principal (DESCUBRE)
                    Text(
                      banner.title.toUpperCase(),
                      style: TextStyle(
                        color: Color(
                          _hexToColor(banner.textColor ?? '#08522B'),
                        ),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Descripción
                    Text(
                      banner.description,
                      style: TextStyle(
                        color: Color(
                          _hexToColor(banner.textColor ?? '#08522B'),
                        ),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Botón
                    ElevatedButton(
                      onPressed: banner.onButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          _hexToColor(banner.textColor ?? '#08522B'),
                        ), // Fondo verde oscuro
                        foregroundColor: Color(
                          _hexToColor(banner.buttonTextColor ?? '#F0C339'),
                        ), // Texto del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        banner.buttonText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🌄 LADO DERECHO: Trapecio pequeño con imagen de fondo
          Expanded(
            flex: 2, // ✅ Ocupa el 40% aprox. del ancho total
            child: ClipPath(
              clipper: RightTrapezoidClipper(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      banner.backgroundImage ??
                          // Imagen por defecto de senderismo en montaña 🌄
                          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=60',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(
                        0.2,
                      ), // Filtro suave para mejorar contraste
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // MÉTODO: Convertir color hexadecimal a int
  // ============================================
  int _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Se agrega opacidad completa si no existe
    }
    return int.parse(hex, radix: 16);
  }
}

// ============================================
// CLASE: ClipPath para el trapecio izquierdo
// (más ancho e inclinado hacia la derecha)
// ============================================
class LeftTrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.92, 0); // línea superior
    path.lineTo(size.width, size.height); // diagonal inferior derecha
    path.lineTo(0, size.height); // base inferior
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ============================================
// CLASE: ClipPath para el trapecio derecho
// (más pequeño e inclinado hacia la izquierda)
// ============================================
class RightTrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.08, size.height); // Inclinación hacia adentro
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
