// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menus.dart
// ============================================

// Importa el paquete principal de Flutter para crear widgets.
import 'package:flutter/material.dart';

// Importa los modelos personalizados de la aplicación (CategoryItem, etc.).
import '../../models/app_models.dart';

// Define un widget sin estado (StatelessWidget) llamado AreaMenus.
class AreaMenus extends StatelessWidget {
  // Lista de elementos del menú, cada uno representado por un CategoryItem.
  final List<CategoryItem> menuItems;

  // Título opcional que se mostrará encima del grid.
  final String? title;

  // Número de columnas del grid, por defecto 3.
  final int columns;

  // Constructor del widget con parámetros requeridos y opcionales.
  const AreaMenus({
    Key? key,
    required this.menuItems, // Lista obligatoria de ítems.
    this.title, // Título opcional.
    this.columns = 3, // Valor por defecto para columnas.
  }) : super(key: key);

  // Método principal que construye la interfaz del widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // Margen interno general.
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea el contenido a la izquierda.
        children: [
          // Si se proporciona un título, lo muestra con un estilo específico.
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ), // Espacio debajo del título.
              child: Text(
                title!, // Texto del título.
                style: const TextStyle(
                  fontSize: 20, // Tamaño del texto.
                  fontWeight: FontWeight.bold, // Texto en negrita.
                  color: Color(0xFF2C5F4F), // Color verde oscuro.
                ),
              ),
            ),

          // Construye un grid de elementos de menú.
          GridView.builder(
            shrinkWrap: true, // Permite usar el GridView dentro de un Column.
            physics:
                const NeverScrollableScrollPhysics(), // Evita scroll interno (usa el del padre).
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns, // Número de columnas definido.
              crossAxisSpacing: 16, // Espacio horizontal entre los elementos.
              mainAxisSpacing: 16, // Espacio vertical entre los elementos.
              childAspectRatio: 1.2, // Relación ancho/alto de cada celda.
            ),
            itemCount: menuItems.length, // Número total de ítems en el menú.
            itemBuilder: (context, index) {
              // Llama al método privado que construye cada ítem.
              return _buildMenuItem(menuItems[index]);
            },
          ),
        ],
      ),
    );
  }

  // Método privado que construye un ítem individual del menú.
  Widget _buildMenuItem(CategoryItem item) {
    return InkWell(
      onTap: item.onTap, // Acción al tocar el ítem (definida en el modelo).
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco.
          borderRadius: BorderRadius.circular(12), // Bordes redondeados.
          border: Border.all(
            color: const Color(0xFF2C5F4F),
            width: 1,
          ), // Borde verde oscuro.
          boxShadow: const [
            // Sombra ligera debajo del ítem.
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra el contenido verticalmente.
          children: [
            // Muestra el ícono del ítem:
            // Si el ícono proviene de los assets, carga una imagen.
            item.icon.startsWith('assets/')
                ? Image.asset(item.icon, width: 40, height: 40)
                // Si no, utiliza un ícono de Flutter según el nombre.
                : Icon(
                    _getIconData(item.icon),
                    color: const Color(0xFF2C5F4F),
                    size: 40,
                  ),
            const SizedBox(height: 8), // Espacio entre ícono y texto.
            // Texto descriptivo del ítem.
            Text(
              item.label, // Etiqueta o nombre del ítem.
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF2C5F4F),
                fontWeight: FontWeight.w600, // Seminegrita.
              ),
              textAlign: TextAlign.center, // Centra el texto.
              maxLines: 2, // Máximo de dos líneas.
              overflow: TextOverflow.ellipsis, // Corta con "..." si es largo.
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar que convierte un nombre de ícono en un IconData de Flutter.
  IconData _getIconData(String iconName) {
    // Mapa que relaciona nombres de iconos con los íconos de Flutter.
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

    // Retorna el ícono correspondiente o uno de ayuda si no existe.
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
