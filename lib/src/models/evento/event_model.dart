// ============================================================
// ARCHIVO: lib/src/models/evento/event_model.dart
// DESCRIPCIÓN: Modelo de datos para representar un evento
// obtenido del backend público Node.js + Express.
// ============================================================

import 'package:imct_flutter/src/api/api_config.dart'; // ✅ Para usar las URLs base

class EventoModel {
  // ------------------------------------------------------------
  // CAMPOS DEL MODELO
  // ------------------------------------------------------------
  final int id; // Identificador único del evento.
  final String nombre; // Título o nombre del evento.
  final String? descripcion; // Texto descriptivo del evento.
  final String? imagen; // URL o ruta de la imagen del evento.
  final String? fecha; // Fecha del evento (si aplica).
  final String? ubicacion; // Lugar o ciudad del evento.
  final bool destacado; // Indica si el evento está marcado como destacado.
  final int? ranking; // Posición dentro del Top 10 (solo si aplica).

  // ------------------------------------------------------------
  // CONSTRUCTOR
  // ------------------------------------------------------------
  EventoModel({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.imagen,
    this.fecha,
    this.ubicacion,
    this.destacado = false,
    this.ranking,
  });

  // ------------------------------------------------------------
  // FACTORY: Convertir desde JSON
  // ------------------------------------------------------------
  factory EventoModel.fromJson(Map<String, dynamic> json) {
    // 👇 Si el backend devuelve el evento anidado dentro de la propiedad "evento"
    final Map<String, dynamic> eventoData = json.containsKey('evento')
        ? json['evento']
        : json;

    return EventoModel(
      id: eventoData['id'] ?? json['id'] ?? 0,
      nombre: eventoData['titulo'] ?? eventoData['nombre'] ?? 'Sin nombre',
      descripcion: eventoData['descripcion'],
      imagen: eventoData['imagen'],
      fecha: eventoData['fecha'],
      ubicacion: eventoData['ubicacion'],
      destacado: eventoData['destacado'] ?? false,
      ranking: json['posicion'] ?? json['ranking'], // usado en Top10
    );
  }

  // ------------------------------------------------------------
  // Convertir a JSON (si necesitas enviar datos al backend)
  // ------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen': imagen,
      'fecha': fecha,
      'ubicacion': ubicacion,
      'destacado': destacado,
      'ranking': ranking,
    };
  }

  // ------------------------------------------------------------
  // OBTENER URL FINAL DE IMAGEN
  // ------------------------------------------------------------
  String getImageUrl() {
    if (imagen != null && imagen!.isNotEmpty) {
      // Si ya es una URL completa, la devolvemos directamente
      if (imagen!.startsWith('http')) {
        return imagen!;
      }

      // 🔗 Unimos la URL base de imágenes con la ruta relativa
      final cleanBase = ApiConfig.baseUrl.replaceAll(RegExp(r'/$'), '');
      final cleanImage = imagen!.replaceAll(RegExp(r'^/'), '');
      return '$cleanBase/$cleanImage';
    }

    // 🖼️ Imagen de respaldo si no hay ninguna
    return 'https://via.placeholder.com/400x300?text=${Uri.encodeComponent(nombre)}';
  }
}
