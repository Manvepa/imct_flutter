// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_informacion_central.dart
// ============================================

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/app_models.dart';

class AreaInformacionCentral extends StatelessWidget {
  final List<CarouselItem>? carouselItems;
  final List<TopListItem>? topListItems;
  final String? topListTitle;
  final String? topListSubtitle;
  final List<CategoryItem>? categories;
  final int categoryColumns;

  const AreaInformacionCentral({
    Key? key,
    this.carouselItems,
    this.topListItems,
    this.topListTitle,
    this.topListSubtitle,
    this.categories,
    this.categoryColumns = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (carouselItems != null && carouselItems!.isNotEmpty)
          _buildCarousel(),
        if (topListItems != null && topListItems!.isNotEmpty) _buildTopList(),
        if (categories != null && categories!.isNotEmpty) _buildCategoryGrid(),
      ],
    );
  }

  Widget _buildCarousel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
          viewportFraction: 0.85,
        ),
        items: carouselItems!.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: item.onTap,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50),
                            );
                          },
                        ),
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
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
        }).toList(),
      ),
    );
  }

  Widget _buildTopList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topListTitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topListTitle!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5F4F),
                    ),
                  ),
                  if (topListSubtitle != null)
                    Text(
                      topListSubtitle!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: topListItems!.length,
              itemBuilder: (context, index) {
                return _buildTopItem(topListItems![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopItem(TopListItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                item.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2C5F4F),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: categoryColumns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          return _buildCategoryItem(categories![index]);
        },
      ),
    );
  }

  Widget _buildCategoryItem(CategoryItem category) {
    return InkWell(
      onTap: category.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  ? Image.asset(category.icon, width: 24, height: 24)
                  : Icon(
                      _getIconData(category.icon),
                      color: const Color(0xFF2C5F4F),
                      size: 24,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF2C5F4F),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
    };
    return iconMap[iconName] ?? Icons.help_outline;
  }
}
