// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart
// ============================================

import 'package:flutter/material.dart';

// Importamos los modelos de datos utilizados
import '../models/app_models.dart';
import '../models/evento/event_model.dart';

// Importamos el servicio para consumir la API de eventos
import '../services/eventos/evento_service.dart';

// Importamos los widgets personalizados
import 'pantallaInicio/area_info_basica.dart';
import 'pantallaInicio/area_menu.dart';
import 'pantallaInicio/area_informacion_central.dart';
import 'pantallaInicio/area_banners.dart';
import 'pantallaInicio/area_menus.dart';

// Importamos el modal de detalle del evento
import '../widgets/evento_detalle_modal.dart';

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
  // Índice actual del menú principal
  int selectedMenuIndex = 0;

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
    return Scaffold(
      body: RefreshIndicator(
        // Permite recargar la información al hacer scroll hacia abajo
        onRefresh: _cargarEventosTop10,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // 🟩 SECCIÓN 1: Información básica (hora, clima, ciudad, íconos)
              AreaInfoBasica(
                cityName: 'Bucaramanga',
                backgroundImage:
                    'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=800',
                backgroundColor: '#2C5F4F',
                showStatusBar: true,
                items: _getInfoBasicaItems(),
              ),

              // 🟩 SECCIÓN 2: Menú principal horizontal
              AreaMenu(
                menuItems: _getMenuItems(),
                initialIndex: selectedMenuIndex,
                onItemTap: (index) => setState(() {
                  selectedMenuIndex = index;
                }),
                backgroundColor: '#89C53F',
                selectedColor: '#085029',
              ),

              // 🟩 SECCIÓN 3: Carrusel de información central (Top 10 eventos)
              Container(
                width: double.infinity, // ✅ Ocupa todo el ancho
                color: const Color(0xFF085029), // 🎨 Fondo verde oscuro
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ), // Espaciado interno
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🏷️ Título personalizado con salto de línea visual
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ), // Espacio debajo del título
                      child: RichText(
                        text: TextSpan(
                          children: [
                            // 🔹 Primera línea: "Top 10 para"
                            const TextSpan(
                              text: 'Top 10 para\n',
                              style: TextStyle(
                                color: Colors.white, // 🎨 Blanco puro
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2, // Espaciado vertical
                                letterSpacing: 0.5,
                              ),
                            ),
                            // 🔹 Segunda línea: "en familia"
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 70,
                                ), // 👈 Desplazamiento hacia la derecha
                                child: Text(
                                  'en familia',
                                  style: const TextStyle(
                                    color: Color(0xFF89C53F), // 🎨 Verde claro
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
              ),

              // 🟩 SECCIÓN 4: NUEVA SECCIÓN “¿SABÍAS QUÉ?”
              // 🟩 SECCIÓN 3.1: ¿SABÍAS QUÉ? (Nueva sección de ancho completo)
              Container(
                width: double.infinity, // ✅ Ocupa todo el ancho de la pantalla
                color: const Color(0xFF89C53F), // Fondo verde (#89C53F)
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ), // Espaciado interno
                // Contenido del bloque: texto en columna
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinear texto a la izquierda
                  children: const [
                    // Subtítulo "¿SABÍAS QUÉ?"
                    Text(
                      '¿SABÍAS QUÉ?',
                      style: TextStyle(
                        color: Color(
                          0xFF085029,
                        ), // Color del subtítulo (#085029)
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10), // Espacio entre subtítulo y texto
                    // Texto descriptivo
                    Text(
                      'Bucaramanga tiene más de 72 parques dentro de su área metropolitana, '
                      'lo que la hace una ciudad de destacado desarrollo urbano sostenible y un paisaje verde.',
                      style: TextStyle(
                        color: Color(0xFF08522F), // Color del texto (#08522F)
                        fontSize: 14,
                        height: 1.5, // Espaciado entre líneas
                      ),
                    ),
                  ],
                ),
              ),

              // 🟩 SECCIÓN 5: Banner “DESCUBRE”
              AreaBanners(banners: _getBannerData()),

              // 🟩 SECCIÓN 6: Íconos de Hoteles y Restaurantes
              AreaMenus(
                title: 'Recomendados',
                menuItems: _getCategoryItems(),
                columns: 2,
              ),

              // 🟩 SECCIÓN 7: “Explora más” (Relax, Ecoturismo...)
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

    // Si todo está correcto, mostramos el carrusel
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
      icon: 'hotel',
      label: 'Hoteles',
      onTap: () => _navigateTo('Hoteles'),
    ),
    CategoryItem(
      icon: 'restaurant',
      label: 'Restaurantes',
      onTap: () => _navigateTo('Restaurantes'),
    ),
  ];

  // Banner con el contenido “DESCUBRE”
  List<BannerData> _getBannerData() => [
    BannerData(
      title: 'DESCUBRE',
      description:
          'Descubre su encanto entre parques, montañas y senderismo, una tradición que enamora a cada visitante.',
      buttonText: 'Ver más',
      backgroundColor: '#F0C339',
      textColor: '#08522B',
      buttonTextColor: '#F0C339',
      onButtonPressed: () => _navigateTo('Info Parques'),
    ),
  ];

  List<CategoryItem> _getBottomMenuItems() => [
    CategoryItem(icon: 'spa', label: 'Relax', onTap: () => _navigateTo('Spa')),
    CategoryItem(
      icon: 'park',
      label: 'Ecoturismo',
      onTap: () => _navigateTo('Ecoturismo'),
    ),
  ];

  // ============================================
  // MÉTODO DE NAVEGACIÓN TEMPORAL (SnackBar)
  // ============================================
  void _navigateTo(String destino) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando a: $destino')));
  }
}
