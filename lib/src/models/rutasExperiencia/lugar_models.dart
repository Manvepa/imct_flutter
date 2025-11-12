// ============================================
// ARCHIVO: lib/src/models/lugar_models.dart
// Modelos de datos para lugares turísticos
// ============================================

/// Modelo principal que representa un lugar en el Top 10
///
/// Contiene la información de posicionamiento y la referencia
/// al objeto Lugar con los detalles completos.
class LugarTop {
  final int id;
  final int lugarId;
  final int posicion;
  final String? createdAt;
  final String? updatedAt;
  final Lugar lugar;

  LugarTop({
    required this.id,
    required this.lugarId,
    required this.posicion,
    this.createdAt,
    this.updatedAt,
    required this.lugar,
  });

  /// Crea una instancia desde JSON (respuesta de la API)
  factory LugarTop.fromJson(Map<String, dynamic> json) {
    return LugarTop(
      id: json['id'],
      lugarId: json['lugarId'],
      posicion: json['posicion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      lugar: Lugar.fromJson(json['lugar']),
    );
  }

  /// Convierte la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lugarId': lugarId,
      'posicion': posicion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lugar': lugar.toJson(),
    };
  }
}

/// Modelo que representa un lugar turístico
///
/// Contiene la información básica del lugar: nombre, descripción e imagen.
class Lugar {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;

  Lugar({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
  });

  /// Crea una instancia desde JSON (respuesta de la API)
  factory Lugar.fromJson(Map<String, dynamic> json) {
    return Lugar(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
    );
  }

  /// Convierte la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen': imagen,
    };
  }
}
