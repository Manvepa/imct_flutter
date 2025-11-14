// ============================================
// ARCHIVO: lib/src/widgets/rutas/area_lugares_carousel.dart
// Contiene TODA la lógica del carousel y ahora
// las peticiones se realizan usando DIO + ApiConfig + Endpoints.
// ============================================

import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // ← Nuevo: usamos Dio

// Nuevo: Importamos tu cliente configurado y los endpoints
import '../../../api/dio_client.dart';
import '../../../api/endpoints.dart';

// Importa los modelos de datos
import '../../../models/rutasExperiencia/lugar_models.dart';

// Importa el widget visual de la tarjeta individual
import 'lugar_card.dart';

// Logging
import 'package:logger/logger.dart';

// ============================================
// WIDGET CON ESTADO: AreaLugaresCarousel
// Maneja la lógica de carga y presentación del carousel
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
    viewportFraction: 0.85, // Muestra parte de tarjetas laterales
  );
  int _currentPage = 0;

  // ============================================
  // CICLO DE VIDA DEL WIDGET
  // ============================================
  @override
  void initState() {
    super.initState();
    _fetchLugares(); // Carga inicial

    // Listener de cambio de página
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() => _currentPage = next);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ============================================
  // FUNCIÓN DE CARGA DE LUGARES USANDO DIO
  // Aquí reemplazamos http.get() por DioClient.instance
  // y usamos Endpoints.lugaresTop10
  // ============================================
  Future<void> _fetchLugares() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Usamos la instancia global de Dio con:
      // - Base URL configurada
      // - Interceptores
      // - Headers globales
      final dio = DioClient.instance;

      // Realizamos la petición sin escribir la URL a mano
      final response = await dio.get(Endpoints.lugaresTop10);

      // Si el backend responde OK (200):
      if (response.statusCode == 200) {
        // Si tu backend devuelve un arreglo directo:
        final List data = response.data;

        setState(() {
          lugares = data.map((e) => LugarTop.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Error específico de Dio
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar los lugares';
      });
      _logger.e('❌ Error Dio: ${e.message}');
    } catch (e) {
      // Error genérico
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar los lugares';
      });
      _logger.e('❌ Error desconocido: $e');
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
                  foregroundColor: Color(0xFF9C4F96),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
    // CAROUSEL DE LUGARES
    // ============================================
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView.builder(
        controller: _pageController,
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];

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
