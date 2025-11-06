// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart (ACTUALIZADO)
// Integración con la API de eventos
// ============================================

// Importa las librerías necesarias del SDK de Flutter.
import 'package:flutter/material.dart';

// Importa los modelos personalizados de la aplicación.
import '../models/app_models.dart';

// Importa el modelo de eventos que representa la estructura de un evento.
import '../models/evento/event_model.dart';

// Importa el servicio que se encarga de obtener los eventos desde la API.
import '../services/eventos/evento_service.dart';

// Importa los widgets personalizados que componen las diferentes secciones
// de la pantalla principal.
import 'pantallaInicio/area_info_basica.dart';
import 'pantallaInicio/area_menu.dart';
import 'pantallaInicio/area_informacion_central.dart';
import 'pantallaInicio/area_banners.dart';
import 'pantallaInicio/area_menus.dart';

// ============================================
// CLASE PRINCIPAL DE LA PANTALLA HOME
// ============================================

// Define un widget con estado (StatefulWidget) para la pantalla principal.
class HomeScreen extends StatefulWidget {
  // Constructor por defecto.
  const HomeScreen({Key? key}) : super(key: key);

  // Crea el estado asociado a este widget.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ============================================
// ESTADO DE LA PANTALLA HOME
// ============================================

// Esta clase maneja la lógica y los datos del HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  // Índice del menú principal seleccionado por el usuario.
  int selectedMenuIndex = 0;

  // Instancia del servicio que obtiene los eventos desde la API.
  final EventoService _eventoService = EventoService();

  // Variables de estado para el manejo de carga y errores.
  bool _isLoadingEventos = true; // Indica si los eventos se están cargando.
  String? _errorMessage; // Almacena un mensaje de error, si ocurre.
  List<EventoModel> _eventosTop10 = []; // Lista con los 10 eventos obtenidos.

  // Método que se ejecuta automáticamente al crear el widget.
  @override
  void initState() {
    super.initState();
    // Carga los eventos al iniciar la pantalla.
    _cargarEventosTop10();
  }

  // ============================================
  // MÉTODO: Cargar los eventos desde la API
  // ============================================
  Future<void> _cargarEventosTop10() async {
    // Actualiza el estado inicial de carga.
    setState(() {
      _isLoadingEventos = true; // Comienza la carga.
      _errorMessage = null; // Limpia mensajes previos.
    });

    try {
      // Solicita los eventos al servicio remoto.
      final eventos = await _eventoService.getTop10Eventos();

      // Actualiza la interfaz con los datos recibidos.
      setState(() {
        _eventosTop10 = eventos; // Asigna los eventos obtenidos.
        _isLoadingEventos = false; // Finaliza la carga.
      });
    } catch (e) {
      // Captura cualquier error ocurrido durante la solicitud.
      setState(() {
        _errorMessage = e.toString(); // Guarda el error.
        _isLoadingEventos = false; // Finaliza el estado de carga.
      });

      // Si el widget sigue montado en pantalla, muestra un mensaje visual.
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

  // ============================================
  // MÉTODO BUILD: Construcción visual del widget principal
  // ============================================
  @override
  Widget build(BuildContext context) {
    // Usa un Scaffold como estructura principal.
    return Scaffold(
      // El cuerpo principal del Scaffold.
      body: RefreshIndicator(
        // Permite al usuario actualizar arrastrando hacia abajo.
        onRefresh: _cargarEventosTop10,

        // Contenedor que permite desplazarse verticalmente.
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // ===============================
              // SECCIÓN 1: Información básica
              // ===============================
              AreaInfoBasica(
                cityName: 'Bucaramanga', // Nombre de la ciudad mostrada.
                backgroundImage:
                    'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=800', // Imagen de fondo.
                backgroundColor: '#2C5F4F', // Color de fondo principal.
                showStatusBar: true, // Muestra la barra de estado superior.
                items: _getInfoBasicaItems(), // Ítems del área informativa.
              ),

              // ===============================
              // SECCIÓN 2: Menú principal
              // ===============================
              AreaMenu(
                menuItems: _getMenuItems(), // Elementos del menú principal.
                initialIndex: selectedMenuIndex, // Índice inicial activo.
                onItemTap: (index) {
                  // Actualiza el estado cuando se selecciona un ítem.
                  setState(() {
                    selectedMenuIndex = index;
                  });
                },
                backgroundColor: '#2C5F4F', // Color de fondo del menú.
                selectedColor: '#FFC107', // Color de ítem seleccionado.
              ),

              // ===============================
              // SECCIÓN 3: Información central
              // ===============================
              _buildAreaInformacionCentral(),

              // ===============================
              // SECCIÓN 4: Banners informativos
              // ===============================
              AreaBanners(banners: _getBannerData()),

              // ===============================
              // SECCIÓN 5: Menús inferiores
              // ===============================
              AreaMenus(
                title: 'Explora más', // Título de la sección.
                menuItems: _getBottomMenuItems(), // Ítems del menú inferior.
                columns: 3, // Número de columnas del grid.
              ),

              // Espacio final al fondo de la pantalla.
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================
  // MÉTODO: Construye el área central según el estado
  // ============================================
  Widget _buildAreaInformacionCentral() {
    // Si los eventos están cargando, muestra un spinner.
    if (_isLoadingEventos) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: const [
            CircularProgressIndicator(
              color: Color(0xFF2C5F4F),
            ), // Animación de carga.
            SizedBox(height: 16),
            Text(
              'Cargando eventos...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    // Si ocurrió un error durante la carga.
    if (_errorMessage != null) {
      return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50, // Fondo rojo claro.
          borderRadius: BorderRadius.circular(12), // Bordes redondeados.
          border: Border.all(color: Colors.red.shade200), // Borde rojo.
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
            // Muestra el mensaje de error específico.
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 16),
            // Botón para reintentar la carga.
            ElevatedButton.icon(
              onPressed: _cargarEventosTop10, // Reintenta la solicitud.
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

    // Si la carga fue exitosa, muestra los datos en el área central.
    return AreaInformacionCentral(
      carouselItems: _getCarouselItems(), // Carrusel dinámico con eventos
      categories: _getCategoryItems(), // Categorías debajo del carrusel
      categoryColumns: 4, // Número de columnas para el grid
    );
  }

  // ============================================
  // MÉTODO: Muestra un modal con los detalles del evento
  // ============================================
  void _verDetalleEvento(EventoModel evento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite altura completa.
      backgroundColor: Colors.transparent, // Fondo transparente.
      builder: (context) => _buildEventoDetalle(evento),
    );
  }

  // ============================================
  // MÉTODO: Construye el contenido del modal del evento
  // ============================================
  Widget _buildEventoDetalle(EventoModel evento) {
    return Container(
      // El modal ocupa el 75% de la pantalla.
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Línea superior del modal (indicador de arrastre).
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Imagen principal del evento.
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              evento.getImageUrl(), // URL de la imagen.
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover, // Ajuste de la imagen.
              // Muestra un contenedor gris si falla la imagen.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 80),
                );
              },
            ),
          ),

          // Contenedor principal con la información del evento.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del evento.
                  Text(
                    evento.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5F4F),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Fecha del evento (si existe).
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

                  // Ubicación del evento (si existe).
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

                  // Descripción del evento (si existe).
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

                  // Botón de acción para obtener más información.
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Cierra el modal.
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
  // MÉTODOS AUXILIARES DE DATOS (para cada área)
  // ============================================

  // Genera los ítems del área "Información básica".
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

  // Genera los ítems del menú principal.
  List<MenuItem> _getMenuItems() => [
    MenuItem(text: 'Experiencias', route: '/experiencias'),
    MenuItem(text: 'Transporte', route: '/transporte'),
    MenuItem(text: 'Compras', route: '/compras'),
    MenuItem(text: 'Comida', route: '/comida'),
    MenuItem(text: 'Vida Nocturna', route: '/vida-nocturna'),
    MenuItem(text: 'Información', route: '/informacion'),
  ];

  // Elementos para el carrusel principal.
  List<CarouselItem> _getCarouselItems() {
    // Si no hay eventos cargados, devuelve un carrusel vacío.
    if (_eventosTop10.isEmpty) return [];

    // Convierte cada evento en un CarouselItem.
    return _eventosTop10.map((evento) {
      return CarouselItem(
        imageUrl: evento.getImageUrl(), // Imagen del evento
        title: evento.nombre, // Nombre del evento como título
        subtitle: evento.ubicacion ?? '', // Ubicación como subtítulo, si existe
        onTap: () => _verDetalleEvento(evento), // Al tocar abre detalle
      );
    }).toList();
  }

  // Categorías de la sección central.
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

  // Banners informativos de la parte media/inferior.
  List<BannerData> _getBannerData() => [
    BannerData(
      title: '¿Sabías qué?',
      description:
          'Bucaramanga tiene más de 72 parques dentro de su área metropolitana.',
      buttonText: 'Ver más',
      backgroundColor: '#D4E157',
      onButtonPressed: () => _navigateTo('Info Parques'),
    ),
  ];

  // Menú inferior adicional con opciones extras.
  List<CategoryItem> _getBottomMenuItems() => [
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

  // ============================================
  // MÉTODO: Simula navegación (muestra mensaje)
  // ============================================
  void _navigateTo(String destination) {
    // Muestra un mensaje tipo "toast" temporal.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a: $destination'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating, // Muestra sobre el contenido.
      ),
    );
  }
}
