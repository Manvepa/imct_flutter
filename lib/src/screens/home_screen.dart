// ============================================
// ARCHIVO: lib/src/screens/home_screen.dart
// Pantalla principal que ensambla todos los componentes
// ============================================

import 'package:flutter/material.dart';

// Importar modelos
import '../models/app_models.dart';

// Importar componentes
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============================================
            // 1. ÁREA INFO BÁSICA (HEADER)
            // ============================================
            AreaInfoBasica(
              cityName: 'Bucaramanga',
              backgroundImage:
                  'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=800',
              backgroundColor: '#2C5F4F',
              showStatusBar: true,
              items: _getInfoBasicaItems(),
            ),

            // ============================================
            // 2. ÁREA MENÚ HORIZONTAL
            // ============================================
            AreaMenu(
              menuItems: _getMenuItems(),
              initialIndex: selectedMenuIndex,
              onItemTap: (index) {
                setState(() {
                  selectedMenuIndex = index;
                });
                print('Menú seleccionado: ${_getMenuItems()[index].text}');
              },
              backgroundColor: '#2C5F4F',
              selectedColor: '#FFC107',
            ),

            // ============================================
            // 3. ÁREA INFORMACIÓN CENTRAL
            // ============================================
            AreaInformacionCentral(
              // Carrusel de imágenes
              carouselItems: _getCarouselItems(),

              // Lista Top 10
              topListItems: _getTopListItems(),
              topListTitle: 'Top 10 para visitar',
              topListSubtitle: 'en familia',

              // Grid de categorías
              categories: _getCategoryItems(),
              categoryColumns: 4,
            ),

            // ============================================
            // 4. ÁREA BANNERS
            // ============================================
            AreaBanners(banners: _getBannerData()),

            // ============================================
            // 5. ÁREA MENÚS (Grid secundario)
            // ============================================
            AreaMenus(
              title: 'Explora más',
              menuItems: _getBottomMenuItems(),
              columns: 3,
            ),

            // Espacio al final
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================
  // MÉTODOS PARA OBTENER DATOS
  // Aquí configuras toda la información de tu app
  // ============================================

  /// Iconos del header (Info Básica)
  List<InfoBasicaItem> _getInfoBasicaItems() {
    return [
      InfoBasicaItem(
        icon: 'info', // Puedes usar 'assets/icons/info.png' para imágenes
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
        label: 'Gastronomía y Deporte',
        onTap: () => _navigateTo('Gastronomía'),
      ),
      InfoBasicaItem(
        icon: 'transport',
        label: 'Movilidad y Servicios',
        onTap: () => _navigateTo('Transporte'),
      ),
    ];
  }

  /// Items del menú horizontal
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

  /// Items del carrusel central
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
      CarouselItem(
        imageUrl:
            'https://images.unsplash.com/photo-1541417904950-b855846fe074?w=800',
        title: 'Aventura y Deporte',
        subtitle: 'Vive la emoción',
        onTap: () => _navigateTo('Deportes'),
      ),
      CarouselItem(
        imageUrl:
            'https://images.unsplash.com/photo-1514984879728-be0aff75a6e8?w=800',
        title: 'Cultura e Historia',
        subtitle: 'Conoce nuestro patrimonio',
        onTap: () => _navigateTo('Cultura'),
      ),
    ];
  }

  /// Items de la lista Top 10
  List<TopListItem> _getTopListItems() {
    return [
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1585974738771-84483dd9f89f?w=400',
        number: '1',
        title: 'Parque del Agua',
        subtitle: 'Naturaleza y diversión',
        onTap: () => _navigateTo('Parque del Agua'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?w=400',
        number: '2',
        title: 'Panachi',
        subtitle: 'Aventura extrema',
        onTap: () => _navigateTo('Panachi'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1587919628307-776024e4f9b8?w=400',
        number: '3',
        title: 'Parque San Pío',
        subtitle: 'Espacio familiar',
        onTap: () => _navigateTo('Parque San Pío'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=400',
        number: '4',
        title: 'Catedral de la Sagrada Familia',
        subtitle: 'Arquitectura religiosa',
        onTap: () => _navigateTo('Catedral'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1542856204-00101eb6def4?w=400',
        number: '5',
        title: 'Parque Santander',
        subtitle: 'Centro histórico',
        onTap: () => _navigateTo('Parque Santander'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=400',
        number: '6',
        title: 'Jardín Botánico',
        subtitle: 'Flora regional',
        onTap: () => _navigateTo('Jardín Botánico'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1533837956061-74d2ca35d1c7?w=400',
        number: '7',
        title: 'Casa de Bolívar',
        subtitle: 'Museo histórico',
        onTap: () => _navigateTo('Casa de Bolívar'),
      ),
      TopListItem(
        imageUrl:
            'https://images.unsplash.com/photo-1541417904950-b855846fe074?w=400',
        number: '8',
        title: 'Chicamocha',
        subtitle: 'Cañón espectacular',
        onTap: () => _navigateTo('Chicamocha'),
      ),
    ];
  }

  /// Items del grid de categorías
  List<CategoryItem> _getCategoryItems() {
    return [
      CategoryItem(
        icon: 'spa', // O usa: 'assets/icons/hoteles.png'
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
      CategoryItem(
        icon: 'transport',
        label: 'Transporte',
        onTap: () => _navigateTo('Transporte'),
      ),
      CategoryItem(
        icon: 'shopping',
        label: 'Compras',
        onTap: () => _navigateTo('Compras'),
      ),
      CategoryItem(
        icon: 'nightlife',
        label: 'Vida Nocturna',
        onTap: () => _navigateTo('Vida Nocturna'),
      ),
      CategoryItem(
        icon: 'hotel',
        label: 'Alojamiento',
        onTap: () => _navigateTo('Alojamiento'),
      ),
    ];
  }

  /// Datos de los banners informativos
  List<BannerData> _getBannerData() {
    return [
      BannerData(
        title: '¿Sabías qué?',
        description:
            'Bucaramanga tiene más de 72 parques dentro de su área metropolitana. Es una ciudad desarrollada con sentido sostenible y un paisaje verde.',
        buttonText: 'Ver más',
        backgroundColor: '#D4E157',
        backgroundImage:
            'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
        onButtonPressed: () => _navigateTo('Info Parques'),
      ),
      BannerData(
        title: 'Descubre',
        description:
            'Descubre su encanto entre parques, montañas y senderos. Una ciudad tradicional que enmarca su belleza natural.',
        buttonText: 'Explorar',
        backgroundColor: '#81C784',
        onButtonPressed: () => _navigateTo('Explorar'),
      ),
    ];
  }

  /// Items del menú inferior (grid secundario)
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
      CategoryItem(
        icon: 'monument',
        label: 'Tours Guiados',
        onTap: () => _navigateTo('Tours'),
      ),
      CategoryItem(
        icon: 'transport',
        label: 'Alquiler Autos',
        onTap: () => _navigateTo('Alquiler'),
      ),
      CategoryItem(
        icon: 'shopping',
        label: 'Centros Comerciales',
        onTap: () => _navigateTo('Centros Comerciales'),
      ),
    ];
  }

  // ============================================
  // MÉTODOS AUXILIARES
  // ============================================

  /// Método para navegar a otras pantallas
  void _navigateTo(String destination) {
    print('Navegando a: $destination');

    // Aquí puedes implementar la navegación real:
    // Navigator.pushNamed(context, '/ruta');
    // O mostrar un diálogo de información

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a: $destination'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
