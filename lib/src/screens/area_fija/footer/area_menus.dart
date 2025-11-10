// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menus.dart
// ============================================

// Importa el paquete principal de Flutter para crear widgets visuales.
import 'package:flutter/material.dart';

// Importa los modelos personalizados (CategoryItem, etc.)
import '../../../models/app_models.dart';

// ===============================================================
// 🟢 WIDGET: AreaMenus
// Representa el bloque con íconos y textos como “Experiencias”, “Transporte”...
// ===============================================================
class AreaMenus extends StatelessWidget {
  // Lista de ítems que se mostrarán (cada uno con ícono, texto y acción).
  final List<CategoryItem> menuItems;

  // Título opcional que se muestra encima del grid.
  final String? title;

  // Número de columnas que tendrá el grid (por defecto, 3).
  final int columns;

  // Constructor del widget con sus parámetros.
  const AreaMenus({
    super.key,
    required this.menuItems, // Lista de ítems (requerida)
    this.title, // Título (opcional)
    this.columns = 3, // Número de columnas por defecto
  });

  // ================================================================
  // MÉTODO PRINCIPAL DE CONSTRUCCIÓN
  // ================================================================
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // Margen interno alrededor del grid.
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea los elementos a la izquierda.
        children: [
          // Si el título existe, se muestra arriba del grid.
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F4F), // Verde oscuro para el título.
                ),
              ),
            ),

          // ========================================================
          // GRID DE ÍCONOS (cada uno construido con _buildMenuItem)
          // ========================================================
          GridView.builder(
            shrinkWrap: true, // Permite usar el grid dentro de un Column.
            physics:
                const NeverScrollableScrollPhysics(), // Evita scroll interno.
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns, // Número de columnas definidas.
              crossAxisSpacing: 16, // Espacio horizontal entre celdas.
              mainAxisSpacing: 16, // Espacio vertical entre celdas.
              childAspectRatio: 1.2, // Relación ancho/alto.
            ),
            itemCount: menuItems.length, // Cantidad total de ítems.
            itemBuilder: (context, index) {
              // Llama al método que construye cada elemento individual.
              return _buildMenuItem(menuItems[index]);
            },
          ),
        ],
      ),
    );
  }

  // ================================================================
  // 🧩 MÉTODO PRIVADO: _buildMenuItem
  // Construye cada tarjeta individual del menú.
  // ================================================================
  Widget _buildMenuItem(CategoryItem item) {
    return InkWell(
      onTap: item.onTap, // Acción al tocar el ítem (definida externamente).
      child: Container(
        decoration: BoxDecoration(
          // ✅ NUEVO COLOR DE FONDO
          color: const Color(0xFF89C53F), // Verde claro (nuevo color)
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
          border: Border.all(
            color: const Color(0xFF6E9F34), // Verde un poco más oscuro (borde)
            width: 1,
          ),
          boxShadow: const [
            // Sombra ligera para profundidad.
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),

        // Contenido interno (ícono + texto)
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra verticalmente el contenido.
          children: [
            // ====================================
            // ÍCONO DEL ÍTEM
            // ====================================
            item.icon.startsWith('assets/')
                // Si el ícono viene de assets → muestra la imagen.
                ? Image.asset(
                    item.icon,
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  )
                // Si no, usa un ícono del sistema de Flutter.
                : Icon(
                    _getIconData(item.icon),
                    color: Colors.white, // ✅ Ícono blanco (contraste)
                    size: 40,
                  ),

            const SizedBox(height: 8), // Espacio entre ícono y texto.
            // ====================================
            // TEXTO DESCRIPTIVO DEL ÍTEM
            // ====================================
            Text(
              item.label, // Texto que viene del modelo.
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white, // ✅ Texto blanco
                fontWeight: FontWeight.w600, // Seminegrita.
              ),
              textAlign: TextAlign.center, // Centrado horizontal.
              maxLines: 2, // Máximo 2 líneas.
              overflow: TextOverflow.ellipsis, // Corta con “…” si es largo.
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // 🔧 MÉTODO AUXILIAR: _getIconData
  // Convierte el nombre del ícono en un objeto IconData de Flutter.
  // ================================================================
  IconData _getIconData(String iconName) {
    final iconMap = {
      'spa': Icons.spa,
      'restaurant': Icons.restaurant,
      'park': Icons.local_activity,
      'monument': Icons.location_city,
      'hotel': Icons.hotel,
      'transport': Icons.directions_bus,
      'shopping': Icons.shopping_bag,
      'nightlife': Icons.nightlife,
    };

    // Si no encuentra coincidencia, usa un ícono genérico.
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
