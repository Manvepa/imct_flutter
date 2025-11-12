// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_info_basica.dart
// ============================================

// Importaciones necesarias para el funcionamiento del widget

// Para manejar temporizadores (Timer)
import 'dart:async'; // Permite ejecutar acciones periódicas

// Para decodificar JSON desde la API
import 'dart:convert'; // Necesario para json.decode

// Paquete base de Flutter con widgets y estilos
import 'package:flutter/material.dart'; // Widgets, estilos, layouts

// Para realizar solicitudes HTTP a APIs externas
import 'package:http/http.dart' as http; // Permite llamadas HTTP

// Importa el modelo InfoBasicaItem de la carpeta de modelos
import '../../../models/app_models.dart'; // Define la estructura de los items

import 'package:flutter_svg/flutter_svg.dart';

// Widget principal que muestra la sección de información básica
// StatefulWidget para poder actualizar hora y clima dinámicamente
class AreaInfoBasica extends StatefulWidget {
  // Nombre de la ciudad a mostrar
  final String cityName; // Nombre de la ciudad

  // Imagen de fondo opcional
  final String? backgroundImage; // URL de la imagen de fondo

  // Color de fondo en formato hexadecimal, si no hay imagen
  final String backgroundColor; // Color de fondo por defecto

  // Lista de íconos o botones que aparecerán en la sección inferior
  final List<InfoBasicaItem> items; // Botones o iconos a mostrar

  // Indica si se debe mostrar la barra de estado superior
  final bool showStatusBar; // true para mostrar, false para ocultar

  // Constructor con parámetros requeridos y opcionales
  const AreaInfoBasica({
    super.key,
    required this.cityName,
    this.backgroundImage =
        'https://res.cloudinary.com/dxn9mrpva/image/upload/v1762728458/lugares_turisticos/eno9glpuhds85fugygqf.jpg',
    this.backgroundColor = '#B3FFFFFF',
    required this.items,
    this.showStatusBar = true,
  });

  // Crea el estado correspondiente a este StatefulWidget
  @override
  State<AreaInfoBasica> createState() => _AreaInfoBasicaState(); // Devuelve el estado privado
}

// Clase privada que define el estado del widget AreaInfoBasica
class _AreaInfoBasicaState extends State<AreaInfoBasica> {
  // Variables para mostrar la hora, la temperatura y el clima
  String _currentTime = ''; // Hora actual como texto
  String _temperature = ''; // Temperatura actual como texto
  String _weatherDescription = ''; // Descripción del clima
  IconData _weatherIcon = Icons.cloud; // Icono del clima (nube por defecto)

  // Temporizador que se ejecuta cada segundo para actualizar la hora
  Timer? _timer; // Puede ser nulo antes de iniciar

  // Se ejecuta al insertar el widget en el árbol de widgets
  @override
  void initState() {
    super.initState(); // Llama al initState de la clase padre
    _updateTime(); // Inicializa la hora actual
    _startClock(); // Inicia el temporizador para actualizar la hora
    _fetchWeather(); // Obtiene datos del clima desde la API
  }

  // Se ejecuta al eliminar el widget de la pantalla
  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador para evitar fugas de memoria
    super.dispose(); // Llama al dispose de la clase padre
  }

  // Inicia un temporizador que actualiza la hora cada segundo
  void _startClock() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTime(),
    ); // Ejecuta _updateTime cada 1 segundo
  }

  // Obtiene la hora actual del sistema y la formatea como HH:mm
  void _updateTime() {
    final now = DateTime.now(); // Fecha y hora actuales
    setState(() {
      // Actualiza el estado con la nueva hora formateada
      _currentTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}'; // Formato HH:mm
    });
  }

  // Obtiene el clima actual desde la API Open-Meteo para Bucaramanga
  Future<void> _fetchWeather() async {
    try {
      // Coordenadas fijas de Bucaramanga
      final url =
          'https://api.open-meteo.com/v1/forecast?latitude=7.1254&longitude=-73.1198&current_weather=true'; // URL de la API

      // Realiza la solicitud HTTP GET
      final response = await http.get(Uri.parse(url)); // Petición a la API

      // Si la respuesta es exitosa
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final data = json.decode(response.body); // Convierte JSON a Map

        // Extrae temperatura y código de clima
        final temp =
            data['current_weather']['temperature']; // Temperatura actual
        final weatherCode =
            data['current_weather']['weathercode']; // Código de clima

        // Mapea el código a descripción e ícono
        final weatherInfo = _mapWeatherCodeToInfo(
          weatherCode,
        ); // Diccionario con descripción e icono

        // Actualiza el estado con los valores obtenidos
        setState(() {
          _temperature = '$temp°C'; // Temperatura en grados
          _weatherDescription =
              weatherInfo['description']!; // Texto descriptivo
          _weatherIcon = weatherInfo['icon']!; // Icono correspondiente
        });
      } else {
        // Si la respuesta falla, asigna valores por defecto
        setState(() {
          _temperature = 'N/D'; // No disponible
          _weatherDescription = 'Desconocido'; // Texto genérico
        });
      }
    } catch (e) {
      // En caso de error (conexión o parsing)
      setState(() {
        _temperature = 'N/D'; // No disponible
        _weatherDescription = 'Error'; // Texto de error
      });
    }
  }

  // Convierte códigos de Open-Meteo en descripción de clima e ícono visual
  Map<String, dynamic> _mapWeatherCodeToInfo(int code) {
    if (code == 0) {
      return {'description': 'Despejado', 'icon': Icons.wb_sunny}; // Sol
    } else if ([1, 2, 3].contains(code)) {
      return {
        'description': 'Parcialmente nublado',
        'icon': Icons.cloud_queue,
      }; // Nubes dispersas
    } else if ([45, 48].contains(code)) {
      return {'description': 'Niebla', 'icon': Icons.foggy}; // Niebla
    } else if ([51, 53, 55].contains(code)) {
      return {
        'description': 'Llovizna',
        'icon': Icons.grain,
      }; // Llovizna ligera
    } else if ([61, 63, 65].contains(code)) {
      return {
        'description': 'Lluvia',
        'icon': Icons.beach_access,
      }; // Lluvia normal
    } else if ([66, 67].contains(code)) {
      return {
        'description': 'Lluvia helada',
        'icon': Icons.ac_unit,
      }; // Lluvia congelada
    } else if ([71, 73, 75].contains(code)) {
      return {'description': 'Nieve', 'icon': Icons.ac_unit}; // Nieve
    } else if ([80, 81, 82].contains(code)) {
      return {'description': 'Aguacero', 'icon': Icons.umbrella}; // Aguacero
    } else if ([95, 96, 99].contains(code)) {
      return {
        'description': 'Tormenta',
        'icon': Icons.flash_on,
      }; // Tormenta eléctrica
    } else {
      return {
        'description': 'Desconocido',
        'icon': Icons.help_outline,
      }; // Código desconocido
    }
  }

  // Construye la interfaz visual del widget
  @override
  Widget build(BuildContext context) {
    return Container(
      // Fondo principal del área
      decoration: BoxDecoration(
        // Si hay imagen de fondo, se muestra
        image: widget.backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(widget.backgroundImage!), // Imagen de URL
                fit: BoxFit.cover, // Ajusta la imagen al contenedor
              )
            : null, // Si no hay imagen, no se aplica
        // Color de fondo si no hay imagen
        color: widget.backgroundImage == null
            ? _hexToColor(widget.backgroundColor) // Convierte hex a Color
            : null,
      ),
      child: Container(
        // Capa semitransparente sobre el fondo
        decoration: BoxDecoration(
          color: _hexToColor('#CBE6D3').withValues(alpha: 0.6),
          // Oscurece el fondo
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ), // Espaciado interno
        child: SafeArea(
          child: Column(
            children: [
              // Barra de estado superior
              if (widget.showStatusBar)
                _buildStatusBar(), // Solo si showStatusBar = true
              if (widget.showStatusBar)
                const SizedBox(height: 20), // Espacio debajo de la barra
              // Nombre de la ciudad en mayúsculas
              Text(
                widget.cityName.toUpperCase(), // Convierte a mayúsculas
                style: const TextStyle(
                  color: Colors.white, // Color del texto
                  fontSize: 32, // Tamaño del texto
                  fontWeight: FontWeight.bold, // Negrita
                  letterSpacing: 2, // Espaciado entre letras
                ),
              ),

              const SizedBox(height: 20), // Separación vertical
              // Sección de botones circulares inferiores
              Wrap(
                spacing: 12, // Espaciado horizontal entre botones
                runSpacing: 12, // Espaciado vertical si hay varias filas
                alignment:
                    WrapAlignment.spaceEvenly, // Distribuye uniformemente
                children: widget.items
                    .map(
                      (item) => _buildIconButton(item),
                    ) // Construye cada botón
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construye la barra superior con hora, clima y íconos
  Widget _buildStatusBar() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Elementos a los extremos
      children: [
        // Muestra la hora actual o "--:--" si no disponible
        Text(
          _currentTime.isEmpty ? '--:--' : _currentTime,
          style: const TextStyle(
            color: Color(0xFF2C5F4F),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        // Sección de la derecha con clima y WiFi/batería
        Row(
          children: [
            Icon(
              _weatherIcon,
              color: Color(0xFF2C5F4F),
              fontWeight: FontWeight.bold,
              size: 18,
            ), // Icono del clima
            const SizedBox(width: 4), // Separación pequeña

            Text(
              _temperature.isEmpty ? '--°C' : _temperature, // Temperatura
              style: const TextStyle(
                color: Color(0xFF2C5F4F),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              _weatherDescription, // Descripción corta del clima
              style: const TextStyle(
                color: Color(0xFF2C5F4F),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),

            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }

  // ============================================
  // MÉTODO: Construye cada botón circular con ícono y texto
  // ============================================
  Widget _buildIconButton(InfoBasicaItem item) {
    return InkWell(
      onTap: item.onTap, // Acción al presionar el botón
      child: SizedBox(
        width: 75, // Ancho fijo del botón
        child: Column(
          children: [
            // 🟢 Contenedor circular para el ícono
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent, // Fondo blanco del círculo
                shape: BoxShape.circle, // Forma circular
                border: Border.all(
                  color: const Color(
                    0xFF2C5F4F,
                  ), // Borde verde oscuro institucional
                  width: 2,
                ),
              ),
              // 📦 Contenido central del ícono
              child: Center(child: _buildDynamicIcon(item.icon)),
            ),

            const SizedBox(height: 8), // Espacio debajo del ícono
            // 🏷️ Texto descriptivo del botón
            Text(
              item.label,
              style: const TextStyle(
                color: Color(0xFF085029),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // MÉTODO AUXILIAR: Dibuja dinámicamente el ícono según su origen
  // ============================================
  Widget _buildDynamicIcon(String iconPath) {
    // 1️⃣ Si el ícono es un SVG remoto (por ejemplo, de Render)
    if (iconPath.endsWith('.svg')) {
      return SvgPicture.network(
        iconPath,
        headers: const {'Accept': 'image/svg+xml'},
        fit: BoxFit.contain,
        width: 28,
        height: 28,
        colorFilter: const ColorFilter.mode(Color(0xFF085029), BlendMode.srcIn),
        placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error_outline, color: Colors.red, size: 24),
      );
    }

    // 2️⃣ Si el ícono es una imagen local (assets/)
    if (iconPath.startsWith('assets/')) {
      return Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.contain);
    }

    // 3️⃣ Si el ícono es una imagen remota (JPG, PNG, WEBP, etc.)
    if (iconPath.startsWith('http') &&
        (iconPath.endsWith('.png') ||
            iconPath.endsWith('.jpg') ||
            iconPath.endsWith('.jpeg') ||
            iconPath.endsWith('.webp'))) {
      return Image.network(
        iconPath,
        width: 28,
        height: 28,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.red, size: 24),
      );
    }

    // 4️⃣ Si el ícono es un nombre de ícono interno de Flutter
    return Icon(
      _getIconData(iconPath),
      color: const Color(0xFF2C5F4F),
      size: 24,
    );
  }

  // Convierte un color hexadecimal a Color de Flutter
  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', ''); // Quita el símbolo #
    return Color(
      int.parse('FF$hex', radix: 16), // Añade opacidad completa y convierte
    );
  }

  // Devuelve un IconData según el nombre del ícono en el modelo
  IconData _getIconData(String iconName) {
    final iconMap = {
      'info': Icons.info,
      'location': Icons.location_on,
      'event': Icons.event,
      'calendar': Icons.calendar_today,
      'restaurant': Icons.restaurant,
      'hotel': Icons.hotel,
      'transport': Icons.directions_bus,
    };
    return iconMap[iconName] ??
        Icons.help_outline; // Devuelve icono por defecto si no existe
  }
}
