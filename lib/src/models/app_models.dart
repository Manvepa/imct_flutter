// ============================================
// ARCHIVO: lib/src/models/app_models.dart
// Modelos de datos reutilizables
// ============================================

/// Modelo para los items del área de información básica (header)
class InfoBasicaItem {
  final String icon; // Nombre del icono o ruta de asset
  final String label; // Texto o etiqueta que acompaña al ícono
  final void Function()?
  onTap; // Función opcional que se ejecuta al tocar el elemento

  // Constructor que recibe los parámetros requeridos y opcionalmente la función onTap
  InfoBasicaItem({required this.icon, required this.label, this.onTap});
}

/// Modelo para los items del menú horizontal
class MenuItem {
  final String text; // Texto que se muestra en el ítem del menú
  final String? route; // Ruta opcional de navegación asociada al ítem

  // Constructor del modelo con el texto obligatorio y la ruta opcional
  MenuItem({required this.text, this.route});
}

/// Modelo para los items del carrusel
class CarouselItem {
  final String imageUrl; // URL o ruta de la imagen mostrada en el carrusel
  final String? title; // Título opcional que puede acompañar la imagen
  final String? subtitle; // Subtítulo opcional debajo del título
  final void Function()? onTap; // Acción opcional al tocar el ítem del carrusel

  // Constructor con parámetros requeridos y opcionales
  CarouselItem({required this.imageUrl, this.title, this.subtitle, this.onTap});
}

/// Modelo para los items de la lista top (Top 10)
class TopListItem {
  final String imageUrl; // Imagen del ítem (por ejemplo, portada o miniatura)
  final String
  number; // Posición o número en la lista (por ejemplo, "1", "2", etc.)
  final String title; // Título principal del ítem
  final String? subtitle; // Subtítulo opcional para más información
  final void Function()? onTap; // Acción opcional al tocar el ítem

  // Constructor con parámetros requeridos y opcionales
  TopListItem({
    required this.imageUrl,
    required this.number,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}

/// Modelo para los items de categorías
class CategoryItem {
  final String icon; // Nombre del icono o ruta del recurso gráfico
  final String label; // Texto descriptivo de la categoría
  final void Function()? onTap; // Acción opcional al tocar la categoría

  // Constructor con los parámetros necesarios y onTap opcional
  CategoryItem({required this.icon, required this.label, this.onTap});
}

/// Modelo para los datos de banners informativos
class BannerData {
  final String title; // Título principal del banner
  final String description; // Descripción o texto informativo del banner
  final String buttonText; // Texto del botón que aparece en el banner
  final String? backgroundImage; // Imagen de fondo opcional del banner
  final String backgroundColor; // Color de fondo del banner (por defecto rojo)
  final String? textColor;
  final String? buttonTextColor;
  final void Function()?
  onButtonPressed; // Acción opcional al presionar el botón

  // Constructor que inicializa todos los atributos, con color predeterminado
  BannerData({
    required this.title,
    required this.description,
    required this.buttonText,
    this.backgroundImage,
    this.backgroundColor =
        '#F0C339', // Valor por defecto para el color de fondo
    this.onButtonPressed,
    this.textColor,
    this.buttonTextColor,
  });
}
