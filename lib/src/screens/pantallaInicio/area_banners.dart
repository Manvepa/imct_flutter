// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_banners.dart
// ============================================

import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class AreaBanners extends StatelessWidget {
  final List<BannerData> banners;

  const AreaBanners({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: banners.map((banner) => _buildBanner(banner)).toList(),
    );
  }

  Widget _buildBanner(BannerData banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _hexToColor(banner.backgroundColor),
        borderRadius: BorderRadius.circular(12),
        image: banner.backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(banner.backgroundImage!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  _hexToColor(banner.backgroundColor).withOpacity(0.9),
                  BlendMode.darken,
                ),
              )
            : null,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            banner.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5F4F),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            banner.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: banner.onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C5F4F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(banner.buttonText),
          ),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
