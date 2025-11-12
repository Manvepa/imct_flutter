// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menu_info.dart
// Descripción: Une la sección de información básica (íconos SVG)
// y el menú superior horizontal. Incluye logs para depuración.
// ============================================

import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // 📦 Logger para imprimir en consola
import '../../../models/app_models.dart';
import 'area_info_basica.dart';
import 'area_menu.dart';
import '../../../constants/app_images.dart';

// ============================================
// WIDGET PRINCIPAL: Área de información básica + menú
// ============================================
class AreaMenuInfo extends StatefulWidget {
  const AreaMenuInfo({super.key});

  @override
  State<AreaMenuInfo> createState() => _AreaMenuInfoState();
}

// ============================================
// ESTADO DEL WIDGET AreaMenuInfo
// ============================================
class _AreaMenuInfoState extends State<AreaMenuInfo> {
  // 🧩 Instancia del logger
  final logger = Logger();

  // Índice actual del menú seleccionado
  int selectedMenuIndex = 0;

  // ============================================
  // MÉTODO PRINCIPAL BUILD
  // ============================================
  @override
  Widget build(BuildContext context) {
    logger.i('🎨 Construyendo AreaMenuInfo...');

    return Column(
      children: [
        // 🟩 SECCIÓN 1: Información básica
        AreaInfoBasica(
          cityName: 'Bucaramanga',
          backgroundColor: '#2C5F4F',
          showStatusBar: true,
          items: _getInfoBasicaItems(), // Íconos del footer (SVG remoto)
        ),

        // 🟩 SECCIÓN 2: Menú principal horizontal
        AreaMenu(
          menuItems: _getMenuItems(),
          initialIndex: selectedMenuIndex,
          onItemTap: (index) {
            logger.i('📲 Menú seleccionado: índice $index');
            setState(() {
              selectedMenuIndex = index;
            });
          },
          backgroundColor: '#89C53F',
          selectedColor: '#085029',
        ),
      ],
    );
  }

  // ============================================
  // DATOS: Íconos SVG del footer (cargados desde Render)
  // ============================================
  List<InfoBasicaItem> _getInfoBasicaItems() {
    logger.i('🧩 Cargando íconos SVG desde el backend...');

    final items = [
      InfoBasicaItem(
        icon: HeaderIcons.descubreBucaramanga,
        label: 'Descubre Bucaramanga',
        onTap: () => _navigateTo('Descubre Bucaramanga'),
      ),
      InfoBasicaItem(
        icon: HeaderIcons.rutasExperiencias,
        label: 'Rutas y experiencias',
        onTap: () => _navigateTo('Rutas y Experiencias'),
      ),
      InfoBasicaItem(
        icon: HeaderIcons.saboresRegion,
        label: 'Sabores de la Región',
        onTap: () => _navigateTo('Sabores de la Región'),
      ),
      InfoBasicaItem(
        icon: HeaderIcons.agendaEventos,
        label: 'Agenda y Eventos',
        onTap: () => _navigateTo('Agenda y Eventos'),
      ),
      InfoBasicaItem(
        icon: HeaderIcons.aventuraDeporte,
        label: 'Aventura y Deporte',
        onTap: () => _navigateTo('Aventura y Deporte'),
      ),
      InfoBasicaItem(
        icon: HeaderIcons.hospedajeServicios,
        label: 'Hospedaje y Servicios',
        onTap: () => _navigateTo('Hospedaje y Servicios'),
      ),
    ];

    // 🔍 Log de cada ícono para confirmar la URL
    for (final item in items) {
      logger.i('🖼️ Icono cargado: ${item.label} → ${item.icon}');
    }

    return items;
  }

  // ============================================
  // DATOS: Menú inferior (texto)
  // ============================================
  List<MenuItem> _getMenuItems() {
    logger.i('📋 Cargando ítems del menú inferior...');
    return [
      MenuItem(text: 'Experiencias', route: '/experiencias'),
      MenuItem(text: 'Transporte', route: '/transporte'),
      MenuItem(text: 'Compras', route: '/compras'),
    ];
  }

  // ============================================
  // MÉTODO TEMPORAL DE NAVEGACIÓN (simulado)
  // ============================================
  void _navigateTo(String destino) {
    logger.i('🚀 Navegando a: $destino');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando a: $destino')));
  }
}
