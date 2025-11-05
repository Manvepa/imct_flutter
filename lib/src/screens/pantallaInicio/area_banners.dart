// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_banners.dart
// ============================================

// Importa el paquete principal de Flutter para usar widgets y materiales visuales.
import 'package:flutter/material.dart';

// Importa el archivo de modelos donde se define la clase BannerData.
import '../../models/app_models.dart';

// Define un widget sin estado (StatelessWidget) llamado AreaBanners.
class AreaBanners extends StatelessWidget {
  // Lista de objetos BannerData que contendrá la información de los banners.
  final List<BannerData> banners;

  // Constructor del widget que recibe la lista de banners como parámetro requerido.
  const AreaBanners({Key? key, required this.banners}) : super(key: key);

  // Método que construye la interfaz de usuario del widget.
  @override
  Widget build(BuildContext context) {
    // Retorna una columna que contiene todos los banners generados dinámicamente.
    return Column(
      // Convierte cada objeto BannerData en un widget llamando al método _buildBanner.
      // Luego convierte el iterable resultante en una lista de widgets.
      children: banners.map((banner) => _buildBanner(banner)).toList(),
    );
  }

  // Método privado que construye visualmente cada banner individual.
  Widget _buildBanner(BannerData banner) {
    // Retorna un contenedor que representa la tarjeta visual del banner.
    return Container(
      // Margen externo del banner (espacio fuera del contenedor).
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Espaciado interno del banner (relleno interno del contenedor).
      padding: const EdgeInsets.all(20),
      // Decoración visual del contenedor (color, bordes, imágenes, sombra, etc.)
      decoration: BoxDecoration(
        // Asigna el color de fondo usando el método que convierte hex a Color.
        color: _hexToColor(banner.backgroundColor),
        // Bordes redondeados del contenedor.
        borderRadius: BorderRadius.circular(12),
        // Si existe una imagen de fondo, se la aplica con ciertos efectos.
        image: banner.backgroundImage != null
            ? DecorationImage(
                // Carga la imagen desde una URL usando NetworkImage.
                image: NetworkImage(banner.backgroundImage!),
                // Ajusta la imagen para cubrir completamente el área.
                fit: BoxFit.cover,
                // Aplica un filtro de color oscuro sobre la imagen.
                colorFilter: ColorFilter.mode(
                  _hexToColor(banner.backgroundColor).withOpacity(0.9),
                  BlendMode.darken,
                ),
              )
            // Si no hay imagen de fondo, no se aplica ninguna.
            : null,
        // Sombra debajo del contenedor para darle profundidad visual.
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      // Contenido interno del banner organizado en columna.
      child: Column(
        // Alinea los elementos al inicio del eje horizontal (izquierda).
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Muestra el título del banner en mayúsculas.
          Text(
            banner.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20, // Tamaño de letra del título.
              fontWeight: FontWeight.bold, // Estilo negrita.
              color: Color(0xFF2C5F4F), // Color del texto del título.
            ),
          ),
          // Espaciado vertical entre el título y la descripción.
          const SizedBox(height: 12),
          // Muestra la descripción del banner.
          Text(
            banner.description,
            style: const TextStyle(
              fontSize: 14, // Tamaño del texto descriptivo.
              color: Colors.black87, // Color del texto.
              height: 1.5, // Altura de línea (espaciado entre líneas).
            ),
          ),
          // Espacio entre la descripción y el botón.
          const SizedBox(height: 16),
          // Botón elevado (ElevatedButton) que ejecuta una acción al presionarlo.
          ElevatedButton(
            // Acción a ejecutar cuando se presiona el botón (puede ser nula).
            onPressed: banner.onButtonPressed,
            // Estilo personalizado del botón.
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF2C5F4F,
              ), // Color de fondo del botón.
              foregroundColor: Colors.white, // Color del texto del botón.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ), // Bordes redondeados del botón.
              ),
              // Relleno interno (espaciado) del botón.
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            // Texto que se muestra dentro del botón.
            child: Text(banner.buttonText),
          ),
        ],
      ),
    );
  }

  // Método privado que convierte un código de color hexadecimal (String) a un objeto Color.
  Color _hexToColor(String hex) {
    // Elimina el símbolo '#' si está presente en el string.
    hex = hex.replaceAll('#', '');
    // Convierte el string hexadecimal en un valor entero y lo transforma en Color.
    // Se agrega 'FF' al inicio para indicar opacidad completa (100%).
    return Color(int.parse('FF$hex', radix: 16));
  }
}
