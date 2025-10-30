// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart (ACTUALIZADO)
// Integración con la API de eventos
// ============================================

import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../models/evento/event_model.dart';
import '../services/eventos/evento_service.dart';
import 'pantallaInicio/area_info_basica.dart';
import 'pantallaInicio/area_menu.dart';
import 'pantallaInicio/area_informacion_central.dart';
import 'pantallaInicio/area_banners.dart';
import 'pantallaInicio/area_menus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMenuIndex = 0;
  final EventoService _eventoService = EventoService();

  // Variables para manejar el estado de carga
  bool _isLoadingEventos = true;
  String? _errorMessage;
  List<EventoModel> _eventosTop10 = [];

  @override
  void initState() {
    super.initState();
    _cargarEventosTop10();
  }

  /// Cargar los eventos Top 10 desde la API
  Future<void> _cargarEventosTop10() async {
    setState(() {
      _isLoadingEventos = true;
      _errorMessage = null;
    });

    try {
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

      // Mostrar error al usuario
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar eventos: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _cargarEventosTop10,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // ÁREA INFO BÁSICA
              AreaInfoBasica(
                cityName: 'Bucaramanga',
                backgroundImage:
                    'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=800',
                backgroundColor: '#2C5F4F',
                showStatusBar: true,
                items: _getInfoBasicaItems(),
              ),

              // ÁREA MENÚ
              AreaMenu(
                menuItems: _getMenuItems(),
                initialIndex: selectedMenuIndex,
                onItemTap: (index) {
                  setState(() {
                    selectedMenuIndex = index;
                  });
                },
                backgroundColor: '#2C5F4F',
                selectedColor: '#FFC107',
              ),

              // ÁREA INFORMACIÓN CENTRAL
              _buildAreaInformacionCentral(),

              // ÁREA BANNERS
              AreaBanners(banners: _getBannerData()),

              // ÁREA MENÚS
              AreaMenus(
                title: 'Explora más',
                menuItems: _getBottomMenuItems(),
                columns: 3,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget que muestra el área central con manejo de estados
  Widget _buildAreaInformacionCentral() {
    if (_isLoadingEventos) {
      // Estado de carga
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: const [
            CircularProgressIndicator(color: Color(0xFF2C5F4F)),
            SizedBox(height: 16),
            Text(
              'Cargando eventos...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      // Estado de error
      return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Error al cargar eventos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _cargarEventosTop10,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C5F4F),
              ),
            ),
          ],
        ),
      );
    }

    // Estado exitoso - mostrar eventos
    return AreaInformacionCentral(
      carouselItems: _getCarouselItems(),
      topListItems: _convertirEventosATopList(),
      topListTitle: 'Top 10 Eventos',
      topListSubtitle: 'No te los pierdas',
      categories: _getCategoryItems(),
      categoryColumns: 4,
    );
  }

  /// Convertir EventoModel a TopListItem
  List<TopListItem> _convertirEventosATopList() {
    return _eventosTop10.asMap().entries.map((entry) {
      final index = entry.key;
      final evento = entry.value;

      return TopListItem(
        imageUrl: evento.getImageUrl(),
        number: '${index + 1}',
        title: evento.nombre,
        subtitle: evento.ubicacion,
        onTap: () => _verDetalleEvento(evento),
      );
    }).toList();
  }

  /// Navegar a detalle del evento
  void _verDetalleEvento(EventoModel evento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEventoDetalle(evento),
    );
  }

  /// Widget de detalle del evento
  Widget _buildEventoDetalle(EventoModel evento) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle para arrastrar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Imagen del evento
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              evento.getImageUrl(),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 80),
                );
              },
            ),
          ),

          // Información del evento
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5F4F),
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (evento.fecha != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          evento.fecha!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                  const SizedBox(height: 8),

                  if (evento.ubicacion != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            evento.ubicacion!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  if (evento.descripcion != null) ...[
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      evento.descripcion!,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _navigateTo('Más info: ${evento.nombre}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C5F4F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Más información',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // MÉTODOS DE DATOS (sin cambios significativos)
  // ============================================

  List<InfoBasicaItem> _getInfoBasicaItems() {
    return [
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
        label: 'Eventos y Calendario',
        onTap: () => _navigateTo('Eventos'),
      ),
      InfoBasicaItem(
        icon: 'calendar',
        label: 'Agenda',
        onTap: () => _navigateTo('Agenda'),
      ),
      InfoBasicaItem(
        icon: 'restaurant',
        label: 'Gastronomía',
        onTap: () => _navigateTo('Gastronomía'),
      ),
    ];
  }

  List<MenuItem> _getMenuItems() {
    return [
      MenuItem(text: 'Experiencias', route: '/experiencias'),
      MenuItem(text: 'Transporte', route: '/transporte'),
      MenuItem(text: 'Compras', route: '/compras'),
      MenuItem(text: 'Comida', route: '/comida'),
      MenuItem(text: 'Vida Nocturna', route: '/vida-nocturna'),
      MenuItem(text: 'Información', route: '/informacion'),
    ];
  }

  List<CarouselItem> _getCarouselItems() {
    return [
      CarouselItem(
        imageUrl:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        title: 'Parques Naturales',
        subtitle: 'Descubre la naturaleza',
        onTap: () => _navigateTo('Parques'),
      ),
      CarouselItem(
        imageUrl:
            'https://images.unsplash.com/photo-1533837956061-74d2ca35d1c7?w=800',
        title: 'Gastronomía Local',
        subtitle: 'Sabores únicos',
        onTap: () => _navigateTo('Gastronomía'),
      ),
    ];
  }

  List<CategoryItem> _getCategoryItems() {
    return [
      CategoryItem(
        icon: 'spa',
        label: 'Hoteles',
        onTap: () => _navigateTo('Hoteles'),
      ),
      CategoryItem(
        icon: 'restaurant',
        label: 'Restaurantes',
        onTap: () => _navigateTo('Restaurantes'),
      ),
      CategoryItem(
        icon: 'park',
        label: 'Parques',
        onTap: () => _navigateTo('Parques'),
      ),
      CategoryItem(
        icon: 'monument',
        label: 'Monumentos',
        onTap: () => _navigateTo('Monumentos'),
      ),
    ];
  }

  List<BannerData> _getBannerData() {
    return [
      BannerData(
        title: '¿Sabías qué?',
        description:
            'Bucaramanga tiene más de 72 parques dentro de su área metropolitana.',
        buttonText: 'Ver más',
        backgroundColor: '#D4E157',
        onButtonPressed: () => _navigateTo('Info Parques'),
      ),
    ];
  }

  List<CategoryItem> _getBottomMenuItems() {
    return [
      CategoryItem(
        icon: 'spa',
        label: 'Relax y Spa',
        onTap: () => _navigateTo('Spa'),
      ),
      CategoryItem(
        icon: 'restaurant',
        label: 'Comida Típica',
        onTap: () => _navigateTo('Comida Típica'),
      ),
      CategoryItem(
        icon: 'park',
        label: 'Ecoturismo',
        onTap: () => _navigateTo('Ecoturismo'),
      ),
    ];
  }

  void _navigateTo(String destination) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a: $destination'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
