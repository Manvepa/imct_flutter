// 📁 lib/src/models/user_model.dart
// Modelo de datos que representa un usuario en la aplicación.

class UserModel {
  final int id; // Identificador único del usuario
  final String name; // Nombre completo
  final String email; // Correo electrónico
  final String? role; // Rol o tipo de usuario (opcional)

  // Constructor con parámetros requeridos y opcionales
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
  });

  // 🔄 Convierte un mapa JSON recibido del backend a una instancia de UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'],
    );
  }

  // 🔁 Convierte una instancia de UserModel a un mapa JSON (para enviar al backend)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'role': role};
  }
}
