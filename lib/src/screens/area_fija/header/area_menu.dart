// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menu.dart
// Descripción: Muestra el menú horizontal (Experiencias, Transporte,
// Compras) e íconos circulares SVG (InfoBasicaIcon) con logs detallados.
// ============================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Para mostrar SVG remotos
import 'package:logger/logger.dart'; // Para depuración
import '../../../models/app_models.dart';

// ============================================
// Logger global
// ============================================
final Logger logger = Logger();

// ============================================
// WIDGET PRINCIPAL: Área del menú horizontal
// ============================================
class AreaMenu extends StatefulWidget {
  final List<MenuItem> menuItems;
  final void Function(int)? onItemTap;
  final int initialIndex;
  final String backgroundColor;
  final String selectedColor;

  const AreaMenu({
    super.key,
    required this.menuItems,
    this.onItemTap,
    this.initialIndex = 0,
    this.backgroundColor = '#2C5F4F',
    this.selectedColor = '#085029',
  });

  @override
  State<AreaMenu> createState() => _AreaMenuState();
}

// ============================================
// ESTADO: Control del menú
// ============================================
class _AreaMenuState extends State<AreaMenu> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: _hexToColor(widget.backgroundColor),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.menuItems.length,
        separatorBuilder: (context, index) => Container(
          width: 1,
          height: 20,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          color: Colors.white24,
        ),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return _buildMenuItem(widget.menuItems[index], index, isSelected);
        },
      ),
    );
  }

  // ============================================
  // Construye cada elemento del menú
  // ============================================
  Widget _buildMenuItem(MenuItem item, int index, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() => selectedIndex = index);
        widget.onItemTap?.call(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? _hexToColor(widget.selectedColor)
                  : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Center(
          child: Text(
            item.text.toUpperCase(),
            style: TextStyle(
              color: const Color(0xFF085029),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================
  // Convierte color HEX a objeto Color
  // ============================================
  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}

// ============================================
// WIDGET AUXILIAR: InfoBasicaIcon
// Muestra un ícono SVG dentro de un círculo blanco con logs.
// ============================================
class InfoBasicaIcon extends StatelessWidget {
  final String iconName; // URL completa o local del SVG
  const InfoBasicaIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    logger.i("🧩 Intentando cargar icono SVG: $iconName");

    return Container(
      width: 65,
      height: 65,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.network(
          iconName,
          headers: const {'Accept': 'image/svg+xml'},
          placeholderBuilder: (context) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          fit: BoxFit.contain,
          colorFilter: const ColorFilter.mode(
            Color(0xFF085029),
            BlendMode.srcIn,
          ),
          errorBuilder: (context, error, stackTrace) {
            logger.e('❌ Error al cargar SVG: $iconName → $error');
            return const Icon(Icons.error_outline, color: Colors.red, size: 30);
          },
        ),
      ),
    );
  }
}
