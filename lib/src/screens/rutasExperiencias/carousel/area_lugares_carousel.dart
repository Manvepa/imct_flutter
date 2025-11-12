// ============================================
// ARCHIVO: lib/src/widgets/rutas/area_lugares_carousel.dart
// Contiene TODA la lógica: llamadas API, estado, y carousel
// ============================================

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Importa los modelos de datos
import '../../../models/rutasExperiencia/lugar_models.dart';
// Importa el widget visual de la tarjeta individual
import 'lugar_card.dart';
// Importamos para logging
import 'package:logger/logger.dart';

// ============================================
// WIDGET CON ESTADO: AreaLugaresCarousel
// Maneja toda la lógica de carga y presentación
// ============================================
class AreaLugaresCarousel extends StatefulWidget {
  const AreaLugaresCarousel({super.key});

  @override
  State<AreaLugaresCarousel> createState() => _AreaLugaresCarouselState();
}

class _AreaLugaresCarouselState extends State<AreaLugaresCarousel> {
  final Logger _logger = Logger();
  // ============================================
  // ESTADO DEL WIDGET
  // ============================================
  List<LugarTop> lugares = []; // Lista de lugares cargados
  bool isLoading = true; // Indicador de carga
  String? errorMessage; // Mensaje de error si falla la carga

  // Controller del PageView para el carousel
  final PageController _pageController = PageController(
    viewportFraction: 0.85, // Muestra parte de las tarjetas laterales
  );
  int _currentPage = 0; // Página actual del carousel

  // ============================================
  // CICLO DE VIDA
  // ============================================
  @override
  void initState() {
    super.initState();
    _fetchLugares(); // Carga los datos al iniciar

    // Listener para detectar cambios de página
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ============================================
  // LÓGICA DE CARGA DE DATOS (API)
  // ============================================
  Future<void> _fetchLugares() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Llamada a la API
      final response = await http.get(
        Uri.parse(
          'https://appmovil-backend.onrender.com/api/public/lugares/top10',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          lugares = data.map((json) => LugarTop.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar los lugares';
      });
      _logger.e('Error: $e');
    }
  }

  // ============================================
  // BUILD DEL WIDGET
  // ============================================
  @override
  Widget build(BuildContext context) {
    // Estado de carga
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
      );
    }

    // Estado de error
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 60),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchLugares,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF9C4F96),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    // Estado sin datos
    if (lugares.isEmpty) {
      return const Center(
        child: Text(
          'No hay lugares disponibles',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    // ============================================
    // CAROUSEL CON PageView
    // ============================================
    // ============================================
    // CAROUSEL CON PageView (dentro de un contenedor con altura fija)
    // ============================================
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.55, // ajusta según tu diseño
      child: PageView.builder(
        controller: _pageController,
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];

          // AnimatedBuilder para efecto de escala
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;

              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
              }

              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 550,
                  child: child,
                ),
              );
            },
            child: LugarCard(lugar: lugar),
          );
        },
      ),
    );
  }
}
