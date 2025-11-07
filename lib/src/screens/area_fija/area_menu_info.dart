// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menu_info.dart
// ============================================

import 'package:flutter/material.dart';

// Importamos los modelos de datos utilizados
import '../../models/app_models.dart';

// Importamos los widgets personalizados existentes
import 'area_info_basica.dart';
import 'area_menu.dart';

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
  // Índice actual del menú principal
  int selectedMenuIndex = 0;

  // ============================================
  // MÉTODO BUILD PRINCIPAL
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🟩 SECCIÓN 1: Información básica (hora, clima, ciudad, íconos)
        AreaInfoBasica(
          cityName: 'Bucaramanga',
          backgroundColor: '#2C5F4F',
          showStatusBar: true,
          items: _getInfoBasicaItems(),
        ),

        // 🟩 SECCIÓN 2: Menú principal horizontal
        AreaMenu(
          menuItems: _getMenuItems(),
          initialIndex: selectedMenuIndex,
          onItemTap: (index) => setState(() {
            selectedMenuIndex = index;
          }),
          backgroundColor: '#89C53F',
          selectedColor: '#085029',
        ),
      ],
    );
  }

  // ============================================
  // MÉTODOS AUXILIARES DE DATOS
  // ============================================
  List<InfoBasicaItem> _getInfoBasicaItems() => [
    InfoBasicaItem(
      icon: 'info',
      label: 'Información',
      onTap: () => _navigateTo('Info'),
    ),
    InfoBasicaItem(
      icon: 'location',
      label: 'Mapa',
      onTap: () => _navigateTo('Mapa'),
    ),
    InfoBasicaItem(
      icon: 'event',
      label: 'Eventos',
      onTap: () => _navigateTo('Eventos'),
    ),
    InfoBasicaItem(
      icon: 'calendar',
      label: 'Agenda',
      onTap: () => _navigateTo('Agenda'),
    ),
  ];

  List<MenuItem> _getMenuItems() => [
    MenuItem(text: 'Experiencias', route: '/experiencias'),
    MenuItem(text: 'Transporte', route: '/transporte'),
    MenuItem(text: 'Compras', route: '/compras'),
  ];

  // ============================================
  // MÉTODO DE NAVEGACIÓN TEMPORAL (SnackBar)
  // ============================================
  void _navigateTo(String destino) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando a: $destino')));
  }
}
