// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_informacion_central.dart
// ============================================

// Importa el paquete principal de Flutter para construir interfaces.
import 'package:flutter/material.dart';

// Importa el paquete CarouselSlider, usado para crear carruseles de imágenes.
import 'package:carousel_slider/carousel_slider.dart';

// Importa los modelos personalizados de la aplicación (CarouselItem, TopListItem, CategoryItem).
import '../../models/app_models.dart';

// Define un widget sin estado (StatelessWidget) llamado AreaInformacionCentral.
class AreaInformacionCentral extends StatelessWidget {
  // Lista opcional de elementos para el carrusel superior.
  final List<CarouselItem>? carouselItems;

  // Lista opcional de elementos para la lista de "top" (más populares, destacados, etc.).
  final List<TopListItem>? topListItems;

  // Título opcional para la lista superior.
  final String? topListTitle;

  // Subtítulo opcional para la lista superior.
  final String? topListSubtitle;

  // Lista opcional de categorías para mostrar en un grid.
  final List<CategoryItem>? categories;

  // Número de columnas que tendrá el grid de categorías (por defecto 4).
  final int categoryColumns;

  // Constructor del widget, con parámetros opcionales y valor por defecto en las columnas.
  const AreaInformacionCentral({
    Key? key,
    this.carouselItems,
    this.topListItems,
    this.topListTitle,
    this.topListSubtitle,
    this.categories,
    this.categoryColumns = 4,
  }) : super(key: key);

  // Método que construye el árbol de widgets principal.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Si hay elementos en el carrusel, lo construye.
        if (carouselItems != null && carouselItems!.isNotEmpty)
          _buildCarousel(),

        // Si hay categorías, construye el grid.
        if (categories != null && categories!.isNotEmpty) _buildCategoryGrid(),
      ],
    );
  }

  // ===============================
  // SECCIÓN: CARRUSEL DE IMÁGENES
  // ===============================

  // Método privado que construye el carrusel.
  Widget _buildCarousel() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ), // Margen superior e inferior.
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200, // Altura del carrusel.
          autoPlay: true, // Activar autoplay.
          enlargeCenterPage: true, // Agranda el ítem del centro.
          aspectRatio: 16 / 9, // Proporción de aspecto.
          autoPlayInterval: const Duration(
            seconds: 3,
          ), // Intervalo entre transiciones.
          viewportFraction: 0.85, // Porcentaje visible del ancho de cada ítem.
        ),
        // Mapea cada elemento de la lista a un widget.
        items: carouselItems!.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: item.onTap, // Acción al tocar el ítem.
                child: Container(
                  width: MediaQuery.of(
                    context,
                  ).size.width, // Ocupa todo el ancho.
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Bordes redondeados.
                    boxShadow: const [
                      // Sombra para dar profundidad al carrusel.
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Redondea la imagen.
                    child: Stack(
                      fit: StackFit.expand, // Ocupa todo el espacio disponible.
                      children: [
                        // Imagen del carrusel obtenida desde una URL.
                        Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover, // Ajusta la imagen al contenedor.
                          errorBuilder: (context, error, stackTrace) {
                            // Si falla la carga, muestra un contenedor gris con un ícono.
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50),
                            );
                          },
                        ),
                        // Si el ítem tiene título, lo muestra con un gradiente oscuro.
                        if (item.title != null)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment
                                  .bottomLeft, // Coloca el texto abajo a la izquierda.
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Muestra el título del ítem.
                                    Text(
                                      item.title!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Muestra el subtítulo si existe.
                                    if (item.subtitle != null)
                                      Text(
                                        item.subtitle!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(), // Convierte la lista mapeada en una lista de widgets.
      ),
    );
  }

  // ===============================
  // SECCIÓN: GRID DE CATEGORÍAS
  // ===============================

  // Método que construye el grid de categorías.
  Widget _buildCategoryGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap:
            true, // Permite incluir el grid dentro de otro scroll (como Column).
        physics:
            const NeverScrollableScrollPhysics(), // Evita desplazamiento interno.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: categoryColumns, // Número de columnas configuradas.
          crossAxisSpacing: 12, // Espaciado horizontal entre celdas.
          mainAxisSpacing: 12, // Espaciado vertical entre celdas.
          childAspectRatio: 1, // Relación ancho/alto cuadrada.
        ),
        itemCount: categories!.length, // Cantidad de categorías.
        itemBuilder: (context, index) {
          // Construye cada ítem de categoría.
          return _buildCategoryItem(categories![index]);
        },
      ),
    );
  }

  // Construye un elemento de categoría individual.
  Widget _buildCategoryItem(CategoryItem category) {
    return InkWell(
      onTap: category.onTap, // Acción al tocar la categoría.
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centra el contenido verticalmente.
        children: [
          // Icono circular de la categoría.
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2C5F4F), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: category.icon.startsWith('assets/')
                  // Si el icono viene de assets, muestra una imagen.
                  ? Image.asset(category.icon, width: 24, height: 24)
                  // Si no, muestra un ícono del sistema.
                  : Icon(
                      _getIconData(category.icon),
                      color: const Color(0xFF2C5F4F),
                      size: 24,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          // Etiqueta o texto de la categoría.
          Text(
            category.label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF2C5F4F),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Corta texto largo.
          ),
        ],
      ),
    );
  }

  // ===================================
  // MÉTODO AUXILIAR PARA ICONOS
  // ===================================

  // Devuelve el icono adecuado según su nombre en texto.
  IconData _getIconData(String iconName) {
    final iconMap = {
      'spa': Icons.spa,
      'restaurant': Icons.restaurant,
      'park': Icons.local_activity,
      'monument': Icons.location_city,
      'hotel': Icons.hotel,
      'transport': Icons.directions_bus,
    };
    // Si el nombre no coincide, devuelve un ícono de ayuda.
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
