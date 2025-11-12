// 📁 lib/src/screens/pantallaInicio/area_footer.dart
// ------------------------------------------------------------
// Área Footer — contiene los íconos y textos del pie de página.
// El fondo ahora está en un componente aparte (FooterBackground).
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:imct_flutter/src/constants/app_images.dart';

// Instancia global del logger
final Logger logger = Logger();

class AreaFooter extends StatelessWidget {
  const AreaFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // 🔗 Lista de íconos a mostrar
    final List<Map<String, String>> footerItems = [
      {
        'label': 'Información Turísticos',
        'icon': FooterIcons.puntosInformacion,
      },
      {'label': 'Hoteles', 'icon': FooterIcons.Hoteles},
      {'label': 'Restaurantes', 'icon': FooterIcons.Restaurantes},
      {'label': 'Parques', 'icon': FooterIcons.Parques},
      {'label': 'Culturales', 'icon': FooterIcons.SitiosCulturales},
      {'label': 'Monumentos', 'icon': FooterIcons.Monumentos},
      {'label': 'Compras', 'icon': FooterIcons.Compras},
      {'label': 'Seguridad', 'icon': FooterIcons.Seguridad},
      {'label': 'Transporte', 'icon': FooterIcons.Transporte},
      {'label': 'Casa de cambio', 'icon': FooterIcons.CasaDeCambio},
      {'label': 'Cajeros', 'icon': FooterIcons.Cajeros},
    ];

    logger.i("🧭 Construyendo AreaFooter con ${footerItems.length} íconos...");

    return Container(
      width: double.infinity,
      color: const Color(0xFFCBE6D3), // Fondo verde suave
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🧩 Íconos del footer
          Wrap(
            alignment: WrapAlignment.center,
            spacing: screenWidth * 0.06,
            runSpacing: 20,
            children: footerItems.map((item) {
              final label = item['label']!;
              final iconUrl = item['icon']!;
              logger.i("🧩 Cargando ícono del footer: $label ($iconUrl)");

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔵 Círculo del ícono
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBE6D3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2C5F4F),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildFooterIcon(iconUrl),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 🔖 Etiqueta del ícono
                  SizedBox(
                    width: 90,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF2C5F4F),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Construye el widget de imagen o SVG según la extensión
  Widget _buildFooterIcon(String url) {
    final lower = url.toLowerCase();

    if (lower.endsWith('.svg')) {
      logger.i("🖼️ Cargando SVG desde $url");
      return SvgPicture.network(
        url,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        ),
      );
    }

    if (lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg')) {
      logger.i("🖼️ Cargando imagen raster desde $url");
      return Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          logger.e("⚠️ Error al cargar imagen: $url -> $error");
          return const Icon(
            Icons.broken_image,
            color: Colors.redAccent,
            size: 28,
          );
        },
      );
    }

    logger.w("⚠️ Extensión no reconocida, intentando cargar como imagen: $url");
    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        logger.e("❌ Error fallback al cargar: $url -> $error");
        return const Icon(
          Icons.broken_image,
          color: Colors.redAccent,
          size: 28,
        );
      },
    );
  }
}
