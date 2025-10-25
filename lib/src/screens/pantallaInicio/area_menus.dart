// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menus.dart
// ============================================

import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class AreaMenus extends StatelessWidget {
  final List<CategoryItem> menuItems;
  final String? title;
  final int columns;

  const AreaMenus({
    Key? key,
    required this.menuItems,
    this.title,
    this.columns = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F4F),
                ),
              ),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return _buildMenuItem(menuItems[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(CategoryItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2C5F4F), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item.icon.startsWith('assets/')
                ? Image.asset(item.icon, width: 40, height: 40)
                : Icon(
                    _getIconData(item.icon),
                    color: const Color(0xFF2C5F4F),
                    size: 40,
                  ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF2C5F4F),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

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
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
