// 📁 lib/src/models/evento/event_model.dart
// Modelo de datos para eventos, compatible con respuestas anidadas del backend.

class EventoModel {
  final int id;
  final String nombre;
  final String? descripcion;
  final String? imagen;
  final String? fecha;
  final String? ubicacion;
  final bool destacado;
  final int? ranking;

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

  // ✅ Conversión de JSON a objeto EventoModel
  factory EventoModel.fromJson(Map<String, dynamic> json) {
    // 🔍 Si el backend devuelve los datos dentro de un campo "evento", extraemos esa parte.
    final Map<String, dynamic> eventoData = json.containsKey('evento')
        ? json['evento']
        : json;

    return EventoModel(
      id: eventoData['id'] ?? json['id'] ?? 0,
      // 🧩 Detectamos si se usa "titulo" o "nombre" en el JSON
      nombre: eventoData['titulo'] ?? eventoData['nombre'] ?? 'Sin nombre',
      descripcion: eventoData['descripcion'],
      imagen: eventoData['imagen'],
      fecha: eventoData['fecha'],
      ubicacion: eventoData['ubicacion'],
      destacado: eventoData['destacado'] ?? false,
      ranking: json['posicion'] ?? json['ranking'],
    );
  }

  // 🔁 Conversión de objeto a JSON
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

  // 🖼️ Devuelve la URL de la imagen con fallback
  String getImageUrl() {
    if (imagen != null && imagen!.isNotEmpty) {
      if (imagen!.startsWith('http')) {
        return imagen!;
      }
      return 'http://192.168.0.12:3000$imagen'; // 👈 Ajusta la IP si usas otra baseUrl
    }
    return 'https://via.placeholder.com/400x300?text=${Uri.encodeComponent(nombre)}';
  }
}
