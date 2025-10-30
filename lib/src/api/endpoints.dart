// 📁 lib/src/api/endpoints.dart
// Contiene las rutas relativas de las API disponibles en el backend Node.js.

class Endpoints {
  // 👥 Endpoints de ejemplo (puedes personalizarlos según tus rutas en Express)
  static const String users = '/users'; // GET - Listar usuarios
  static const String login = '/auth/login'; // POST - Iniciar sesión
  static const String register = '/auth/register'; // POST - Registrar usuario

  // 🎉 Endpoints de eventos (NUEVOS)
  static const String eventosTop10 = '/public/eventos/top10';
  static const String eventos = '/public/eventos';
  static const String eventoById = '/public/eventos'; // Usar con /{id}
}
