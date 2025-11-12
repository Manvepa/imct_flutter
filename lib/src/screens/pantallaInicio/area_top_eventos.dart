// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_top_eventos.dart
// ============================================

import 'package:flutter/material.dart';

// Importamos los modelos de datos
import '../../models/evento/event_model.dart';
import '../../models/app_models.dart';

// Importamos el servicio para consumir la API de eventos
import '../../services/eventos/evento_service.dart';

// Importamos los widgets personalizados
import 'area_informacion_central.dart';

// Importamos el modal de detalle del evento
import '../../widgets/evento/evento_detalle_modal.dart';

// ============================================
// WIDGET PRINCIPAL: Área de Top 10 de eventos
// ============================================
class AreaTopEventos extends StatefulWidget {
  const AreaTopEventos({super.key});

  @override
  State<AreaTopEventos> createState() => _AreaTopEventosState();
}

// ============================================
// ESTADO DEL WIDGET AreaTopEventos
// ============================================
class _AreaTopEventosState extends State<AreaTopEventos> {
  // Servicio para obtener los eventos desde la API
  final EventoService _eventoService = EventoService();

  // Control de estado de carga
  bool _isLoadingEventos = true;
  String? _errorMessage;

  // Lista donde se almacenan los eventos Top 10
  List<EventoModel> _eventosTop10 = [];

  @override
  void initState() {
    super.initState();
    _cargarEventosTop10();
  }

  // ============================================
  // MÉTODO: Cargar los eventos desde la API
  // ============================================
  Future<void> _cargarEventosTop10() async {
    setState(() {
      _isLoadingEventos = true;
      _errorMessage = null;
    });

    try {
      // Llamada al servicio para obtener los eventos Top 10
      final eventos = await _eventoService.getTop10Eventos();

      setState(() {
        _eventosTop10 = eventos;
        _isLoadingEventos = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoadingEventos = false;
      });

      // Muestra un mensaje de error si la carga falla
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar eventos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ============================================
  // MÉTODO BUILD PRINCIPAL
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Ocupa todo el ancho
      color: const Color(0xFF085029), // 🎨 Fondo verde oscuro
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🏷️ Título personalizado con salto de línea visual
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Top 10 para\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      letterSpacing: 0.5,
                    ),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'en familia',
                        style: const TextStyle(
                          color: Color(0xFF89C53F),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🌀 Carrusel de eventos (mantiene la funcionalidad existente)
          _buildAreaInformacionCentral(),
        ],
      ),
    );
  }

  // ============================================
  // CONSTRUCCIÓN DEL ÁREA CENTRAL (Carrusel Top 10)
  // ============================================
  Widget _buildAreaInformacionCentral() {
    if (_isLoadingEventos) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            CircularProgressIndicator(color: Color(0xFF2C5F4F)),
            SizedBox(height: 16),
            Text('Cargando eventos...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            Text('Error: $_errorMessage'),
            ElevatedButton.icon(
              onPressed: _cargarEventosTop10,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // ✅ Si todo está correcto, mostramos el carrusel
    return AreaInformacionCentral(
      carouselItems: _getCarouselItems(),
      categories: const [],
      categoryColumns: 0,
    );
  }

  // ============================================
  // MOSTRAR DETALLE DEL EVENTO EN MODAL
  // ============================================
  void _verDetalleEvento(EventoModel evento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          EventoDetalleModal(evento: evento, onNavigate: _navigateTo),
    );
  }

  // ============================================
  // GENERAR ITEMS DEL CARRUSEL A PARTIR DE LOS EVENTOS
  // ============================================
  List<CarouselItem> _getCarouselItems() => _eventosTop10
      .map(
        (evento) => CarouselItem(
          imageUrl: evento.getImageUrl(),
          title: evento.nombre,
          subtitle: evento.ubicacion ?? '',
          onTap: () => _verDetalleEvento(evento),
        ),
      )
      .toList();

  // ============================================
  // MÉTODO DE NAVEGACIÓN TEMPORAL (SnackBar)
  // ============================================
  void _navigateTo(String destino) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando a: $destino')));
  }
}
