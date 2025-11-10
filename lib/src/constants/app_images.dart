// ============================================================
// ARCHIVO: lib/src/constants/app_images.dart
// Descripción: Define las rutas completas de los íconos SVG
// servidos desde el backend desplegado en Render.
// ============================================================

// 🔹 URL base de tu backend desplegado (Render)
const String baseBackendUrl = 'https://appmovil-backend.onrender.com';

// ============================================================
// 🧭 ÍCONOS DEL HEADER (ubicados en /images/header/ del backend)
// ============================================================
class HeaderIcons {
  static const String cajeros = '$baseBackendUrl/images/header/Cajeros.svg';
  static const String casaDeCambio =
      '$baseBackendUrl/images/header/Casa_de_cambio.svg';
  static const String compras = '$baseBackendUrl/images/header/Compras.svg';
  static const String hoteles = '$baseBackendUrl/images/header/Hoteles.svg';
  static const String monumentos =
      '$baseBackendUrl/images/header/Monumentos.svg';
  static const String parques = '$baseBackendUrl/images/header/Parques.svg';
  static const String puntosInformacion =
      '$baseBackendUrl/images/header/Puntos_de_informacion.svg';
  static const String restaurantes =
      '$baseBackendUrl/images/header/Restaurantes.svg';
  static const String seguridad = '$baseBackendUrl/images/header/Seguridad.svg';
  static const String sitiosCulturales =
      '$baseBackendUrl/images/header/Sitios_culturales.svg';
  static const String transporte =
      '$baseBackendUrl/images/header/Transporte.svg';
}

// ============================================================
// 🏞️ ÍCONOS DEL FOOTER (ubicados en /images/footer/ del backend)
// ============================================================
class FooterIcons {
  static const String agendaEventos =
      '$baseBackendUrl/images/footer/Agenda_y_eventos.svg';
  static const String aventuraDeporte =
      '$baseBackendUrl/images/footer/Aventura_y_deporte.svg';
  static const String descubreBucaramanga =
      '$baseBackendUrl/images/footer/Descubre_bucaramanga.svg';
  static const String hospedajeServicios =
      '$baseBackendUrl/images/footer/Hospedaje_y_servicios.svg';
  static const String rutasExperiencias =
      '$baseBackendUrl/images/footer/Rutas_y_experiencias.svg';
  static const String saboresRegion =
      '$baseBackendUrl/images/footer/Sabores_de_la_region.svg';
}
