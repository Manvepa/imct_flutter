// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menu.dart
// ============================================

import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class AreaMenu extends StatefulWidget {
  final List<MenuItem> menuItems;
  final void Function(int)? onItemTap;
  final int initialIndex;
  final String backgroundColor;
  final String selectedColor;

  const AreaMenu({
    Key? key,
    required this.menuItems,
    this.onItemTap,
    this.initialIndex = 0,
    this.backgroundColor = '#2C5F4F',
    this.selectedColor = '#FFC107',
  }) : super(key: key);

  @override
  State<AreaMenu> createState() => _AreaMenuState();
}

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

  Widget _buildMenuItem(MenuItem item, int index, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
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
              color: Colors.white,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
