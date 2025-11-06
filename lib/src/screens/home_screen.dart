// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart
// ============================================

import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../models/evento/event_model.dart';
import '../services/eventos/evento_service.dart';

// Importamos los widgets personalizados
import 'pantallaInicio/area_info_basica.dart';
import 'pantallaInicio/area_menu.dart';
import 'pantallaInicio/area_informacion_central.dart';
import 'pantallaInicio/area_banners.dart';
import 'pantallaInicio/area_menus.dart';

// Importamos el nuevo componente separado:
import '../widgets/evento_detalle_modal.dart'; // <--- Nuevo archivo creado

// ============================================
// CLASE PRINCIPAL DE LA PANTALLA HOME
// ============================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ============================================
// ESTADO DE LA PANTALLA HOME
// ============================================

class _HomeScreenState extends State<HomeScreen> {
  int selectedMenuIndex = 0;
  final EventoService _eventoService = EventoService();

  bool _isLoadingEventos = true;
  String? _errorMessage;
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _cargarEventosTop10,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // SECCIÓN 1: Información básica
              AreaInfoBasica(
                cityName: 'Bucaramanga',
                backgroundImage:
                    'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=800',
                backgroundColor: '#2C5F4F',
                showStatusBar: true,
                items: _getInfoBasicaItems(),
              ),

              // SECCIÓN 2: Menú principal
              AreaMenu(
                menuItems: _getMenuItems(),
                initialIndex: selectedMenuIndex,
                onItemTap: (index) => setState(() {
                  selectedMenuIndex = index;
                }),
                backgroundColor: '#89C53F',
                selectedColor: '#085029',
              ),

              // SECCIÓN 3: Información central
              _buildAreaInformacionCentral(),

              // SECCIÓN 4: Banners
              AreaBanners(banners: _getBannerData()),

              // SECCIÓN 5: Menús inferiores
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

  // ============================================
  // CONSTRUCCIÓN DEL ÁREA CENTRAL
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

    return AreaInformacionCentral(
      carouselItems: _getCarouselItems(),
      categories: _getCategoryItems(),
      categoryColumns: 4,
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

  List<CategoryItem> _getCategoryItems() => [
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
  ];

  List<BannerData> _getBannerData() => [
    BannerData(
      title: '¿Sabías qué?',
      description: 'Bucaramanga tiene más de 72 parques.',
      buttonText: 'Ver más',
      backgroundColor: '#89C53F',
      onButtonPressed: () => _navigateTo('Info Parques'),
    ),
  ];

  List<CategoryItem> _getBottomMenuItems() => [
    CategoryItem(icon: 'spa', label: 'Relax', onTap: () => _navigateTo('Spa')),
    CategoryItem(
      icon: 'park',
      label: 'Ecoturismo',
      onTap: () => _navigateTo('Eco'),
    ),
  ];

  void _navigateTo(String destino) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando a: $destino')));
  }
}
