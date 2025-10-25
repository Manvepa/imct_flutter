// ============================================
// ARCHIVO: lib/src/models/app_models.dart
// Modelos de datos reutilizables
// ============================================

/// Modelo para los items del área de información básica (header)
class InfoBasicaItem {
  final String icon; // Nombre del icono o ruta de asset
  final String label;
  final void Function()? onTap;

  InfoBasicaItem({required this.icon, required this.label, this.onTap});
}

/// Modelo para los items del menú horizontal
class MenuItem {
  final String text;
  final String? route;

  MenuItem({required this.text, this.route});
}

/// Modelo para los items del carrusel
class CarouselItem {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final void Function()? onTap;

  CarouselItem({required this.imageUrl, this.title, this.subtitle, this.onTap});
}

/// Modelo para los items de la lista top (Top 10)
class TopListItem {
  final String imageUrl;
  final String number;
  final String title;
  final String? subtitle;
  final void Function()? onTap;

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
  final String icon; // Nombre del icono o ruta de asset
  final String label;
  final void Function()? onTap;

  CategoryItem({required this.icon, required this.label, this.onTap});
}

/// Modelo para los datos de banners informativos
class BannerData {
  final String title;
  final String description;
  final String buttonText;
  final String? backgroundImage;
  final String backgroundColor;
  final void Function()? onButtonPressed;

  BannerData({
    required this.title,
    required this.description,
    required this.buttonText,
    this.backgroundImage,
    this.backgroundColor = '#D4E157',
    this.onButtonPressed,
  });
}
