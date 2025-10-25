// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_info_basica.dart
// ============================================

import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class AreaInfoBasica extends StatelessWidget {
  final String cityName;
  final String? backgroundImage;
  final String backgroundColor;
  final List<InfoBasicaItem> items;
  final bool showStatusBar;

  const AreaInfoBasica({
    Key? key,
    required this.cityName,
    this.backgroundImage,
    this.backgroundColor = '#2C5F4F',
    required this.items,
    this.showStatusBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
        color: backgroundImage == null ? _hexToColor(backgroundColor) : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _hexToColor(backgroundColor).withOpacity(0.85),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              if (showStatusBar) _buildStatusBar(),
              if (showStatusBar) const SizedBox(height: 20),
              Text(
                cityName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.spaceEvenly,
                children: items.map((item) => _buildIconButton(item)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '09:23',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Row(
          children: const [
            Icon(Icons.cloud, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Icon(Icons.wifi, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Icon(Icons.battery_full, color: Colors.white, size: 18),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(InfoBasicaItem item) {
    return InkWell(
      onTap: item.onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2C5F4F), width: 2),
              ),
              child: Center(
                child: item.icon.startsWith('assets/')
                    ? Image.asset(item.icon, width: 24, height: 24)
                    : Icon(
                        _getIconData(item.icon),
                        color: const Color(0xFF2C5F4F),
                        size: 24,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
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

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  IconData _getIconData(String iconName) {
    final iconMap = {
      'info': Icons.info,
      'location': Icons.location_on,
      'event': Icons.event,
      'calendar': Icons.calendar_today,
      'restaurant': Icons.restaurant,
      'hotel': Icons.hotel,
      'transport': Icons.directions_bus,
    };
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
